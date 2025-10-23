<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use App\Models\Anggota;
use App\Models\Barang;
use App\Models\Penjualan;
use App\Models\PenjualanDetail;
use App\Models\Toko;
use BackedEnum;
use Carbon\Carbon;
use Filament\Actions\Action;
use Filament\Schemas\Components\Actions;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Support\Icons\Heroicon;
use Filament\Support\RawJs;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use UnitEnum;

class PosKasir extends Page implements Forms\Contracts\HasForms
{
    use Forms\Concerns\InteractsWithForms;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedShoppingCart;
    protected static string|UnitEnum|null $navigationGroup = 'Transaksi';
    protected static ?string $navigationLabel = 'Kasir';
    protected static ?string $title = 'Kasir';
    protected static ?string $slug = 'kasir-pos';
    protected string $view = 'filament.pages.pos-kasir';
    public ?string $qty_enter_pressed = null;

    public ?array $data = [];
    public ?array $savedTransactionData = null;
    public $showPrintModal = false;

    public function mount(): void
    {
        $this->form->fill([
            'anggota_id' => null,
            'selected_barang_id' => null,
            'items' => [],
            'diskon' => 0,
            'ppn' => 0,
            'bayar' => 0,
            'grand_total' => 0,
            'kembalian' => 0,
        ]);
    }

    protected function getFormSchema(): array
    {
        return [
            // ================= BARIS ATAS - PILIH ANGGOTA & BARANG =================
            Grid::make()
                ->schema([
                    // Pilih Anggota
                    Section::make('Informasi Anggota')
                        ->schema([
                            Forms\Components\Select::make('anggota_id')
                                ->label('Pilih Anggota')
                                ->options(Anggota::pluck('nama', 'id')->toArray())
                                ->searchable()
                                ->preload()
                                ->native(false)
                                ->live()
                                ->required()
                                ->hint('Pilih anggota untuk memulai transaksi'),
                        ])
                        ->columnSpan(2),

                    // Pilih Barang
                    Section::make('Pilih Barang')
                        ->schema([
                            Forms\Components\Select::make('selected_barang_id')
                                ->label('Pilih Barang')
                                ->options(
                                    Barang::where('stok', '>', 0)
                                        ->pluck('nama', 'id')
                                        ->map(fn($nama, $id) => $nama . ' (Stok: ' . Barang::find($id)->stok . ')')
                                        ->toArray()
                                )
                                ->searchable()
                                ->preload()
                                ->live()
                                ->disabled(fn (callable $get) => empty($get('anggota_id')))
                                ->afterStateUpdated(function ($state, callable $get, callable $set) {
                                    if ($state) {
                                        $this->tambahBarangKeCart($state, $get, $set);
                                    }
                                })
                                ->hint(fn (callable $get) => empty($get('anggota_id')) 
                                    ? 'Pilih anggota terlebih dahulu' 
                                    : 'Pilih barang untuk ditambahkan ke keranjang'),
                        ]) 
                        ->columnSpan(2),
                ])
                ->columns(4),

            // ================= BARIS TENGAH - DAFTAR KERANJANG (FULL WIDTH) =================
            Section::make('Daftar Keranjang')
                ->schema([
                    Forms\Components\Repeater::make('items')
                        ->label('')
                        ->schema([
                            Forms\Components\TextInput::make('nama_barang')
                                ->label('Produk')
                                ->readOnly()
                                ->columnSpan(3),

                            Forms\Components\TextInput::make('qty')
                                ->label('Jumlah')
                                ->numeric()
                                ->default(1)
                                ->minValue(1)
                                ->live(onBlur: true)
                                ->afterStateUpdated(function ($state, callable $set, callable $get, $component) {
                                    // Log::info("=== AFTER STATE UPDATED TRIGGERED ===");
                                    $path = $component->getStatePath();
                                    $this->updateQtyManual($state, $set, $get, $path);
                                })
                                ->required()
                                ->columnSpan(1)
                                ->disabled(fn (callable $get) => empty($get('../../anggota_id'))),

                            Forms\Components\TextInput::make('harga_jual')
                                ->label('Harga Satuan')
                                ->numeric()
                                ->prefix('Rp')
                                ->readOnly()
                                ->columnSpan(2),

                            Forms\Components\TextInput::make('total')
                                ->label('Total')
                                ->numeric()
                                ->prefix('Rp')
                                ->readOnly()
                                ->columnSpan(2),
                            Actions::make([
                                Action::make('hapus')
                                    ->label('')
                                    ->icon('heroicon-o-trash')
                                    ->color('danger')
                                    ->action(function ($component) {
                                        $path = $component->getStatePath();
                                        if (preg_match('/data\.items\.(\d+)/', $path, $matches)) {
                                            $this->hapusItem((int)$matches[1]);
                                        }
                                    }),
                            ])
                            ->columnSpan(1),
                        ])
                        ->reorderable(false)
                        ->columns(9)
                        ->default([])
                        ->live()
                        ->afterStateUpdated(fn() => $this->updateGrandTotalManual())
                        ->deletable(false)
                        ->addable(false),
                ])
                ->columnSpanFull(),

            // Tombol Hapus Semua Item
            Actions::make([
                Action::make('hapus_semua')
                    ->label('Hapus Semua Barang')
                    ->color('danger')
                    ->icon('heroicon-o-trash')
                    ->action(function (callable $get, callable $set) {
                        $this->resetCart($set);
                    })
                    ->visible(fn (callable $get) => !empty($get('items'))),
            ])
            ->alignEnd(),

            // ================= BARIS BAWAH - RINGKASAN PEMBAYARAN =================
            Section::make('Ringkasan Pembayaran')
                ->schema([
                    Grid::make(4)
                        ->schema([
                            Forms\Components\TextInput::make('subtotal')
                                ->label('Subtotal')
                                ->numeric()
                                ->prefix('Rp')
                                ->default(0)
                                ->minValue(0)
                                ->mask(RawJs::make('$money($input)'))
                                ->stripCharacters(',')
                                ->readOnly()
                                ->columnSpan(1)
                                ->disabled(fn (callable $get) => empty($get('anggota_id'))),

                            Forms\Components\TextInput::make('diskon')
                                ->label('Diskon')
                                ->numeric()
                                ->prefix('Rp')
                                ->default(0)
                                ->minValue(0)
                                ->live(onBlur: true)
                                ->afterStateUpdated(fn() => $this->updateGrandTotalManual())
                                ->columnSpan(1)
                                ->disabled(fn (callable $get) => empty($get('anggota_id'))),

                            Forms\Components\TextInput::make('ppn')
                                ->label('PPN')
                                ->numeric()
                                ->prefix('Rp')
                                ->default(0)
                                ->minValue(0)
                                ->live(onBlur: true)
                                ->afterStateUpdated(fn() => $this->updateGrandTotalManual())
                                ->columnSpan(1)
                                ->disabled(fn (callable $get) => empty($get('anggota_id'))),

                            Forms\Components\TextInput::make('grand_total')
                                ->label('Grand Total')
                                ->numeric()
                                ->prefix('Rp')
                                ->readOnly()
                                ->default(0)
                                ->columnSpan(1)
                                ->disabled(fn (callable $get) => empty($get('anggota_id'))),
                        ]),

                    Grid::make(4)
                        ->schema([
                            Forms\Components\TextInput::make('bayar')
                                ->label('Jumlah Bayar')
                                ->numeric()
                                ->prefix('Rp')
                                ->minValue(0)
                                ->live(onBlur: true)
                                ->afterStateUpdated(function ($state, callable $set) {
                                    $grandTotal = $this->hitungGrandTotal();
                                    $set('kembalian', max(0, $state - $grandTotal));
                                })
                                ->columnSpan(2)
                                ->disabled(fn (callable $get) => empty($get('anggota_id'))),

                            Forms\Components\TextInput::make('kembalian')
                                ->label('Kembalian')
                                ->numeric()
                                ->prefix('Rp')
                                ->readOnly()
                                ->default(0)
                                ->columnSpan(2)
                                ->disabled(fn (callable $get) => empty($get('anggota_id'))),
                        ]),

                    // Tombol Simpan Transaksi
                    Actions::make([
                        Action::make('simpan')
                            ->label('Bayar')
                            ->button()
                            ->size('lg')
                            ->color('success')
                            ->icon('heroicon-o-currency-dollar')
                            ->disabled(fn () => 
                                empty($this->data['anggota_id']) || 
                                empty($this->data['items']) ||
                                (($this->data['bayar'] ?? 0) < $this->hitungGrandTotal())
                            )
                            ->action(fn() => $this->simpanTransaksi()),

                        Action::make('reset')
                            ->label('Reset Kasir')
                            ->button()
                            ->size('lg')
                            ->color('danger')
                            ->icon('heroicon-o-arrow-path')
                            ->action(function (callable $set) {
                                $this->performReset($set);
                            })
                            ->visible(fn () => !empty($this->data['items']) || !empty($this->data['anggota_id']))
                    ])
                        
                    ->alignEnd(),
                ])
                ->columnSpanFull(),
        ];
    }

protected function getFormStatePath(): string
{
    return 'data';
}

/**
 * Hapus item dari cart dengan optimasi
 */
public function hapusItem(int $index): void
{
    $items = $this->data['items'] ?? [];
    
    if (!isset($items[$index])) {
        return;
    }
    
    // Hapus item dan reset keys
    unset($items[$index]);
    $this->data['items'] = array_values($items);
    
    $this->updateGrandTotalManual();
}

/**
 * Update qty dengan optimasi performa
 */
public function updateQtyManual($state, callable $set, callable $get, string $path): void
{
    // Extract index dari path dengan regex lebih efisien
    if (!preg_match('/data\.items\.(\d+)\.qty/', $path, $matches)) {
        Log::error("Cannot extract index from path: {$path}");
        return;
    }
    
    $index = (int) $matches[1];
    $items = $this->data['items'] ?? [];
    
    if (!isset($items[$index])) {
        Log::error("Item index {$index} not found");
        return;
    }

    // Validasi input
    $state = max(1, (int) $state);
    $barangId = $items[$index]['barang_id'];
    
    // Validasi stok dengan query lebih efisien
    $stokBarang = Barang::where('id', $barangId)->value('stok');
    
    if ($stokBarang === null) {
        Notification::make()
            ->title('Barang tidak ditemukan')
            ->danger()
            ->send();
        return;
    }
    
    if ($state > $stokBarang) {
        $namaBarang = $items[$index]['nama_barang'];
        Notification::make()
            ->title('Stok tidak mencukupi')
            ->body("Stok {$namaBarang} hanya {$stokBarang}")
            ->danger()
            ->send();
        return;
    }

    // Update item data
    $hargaJual = $items[$index]['harga_jual'];
    $items[$index]['qty'] = $state;
    $items[$index]['total'] = $state * $hargaJual;
    
    $this->data['items'] = $items;
    $this->updateGrandTotalManual();
}

/**
 * Reset cart dengan optimasi
 */
public function resetCart(): void
{
    $this->data = array_merge($this->data, [
        'items' => [],
        'selected_barang_id' => null,
        'diskon' => 0,
        'ppn' => 0,
        'bayar' => 0,
        'grand_total' => 0,
        'kembalian' => 0,
    ]);
    
    $this->updateGrandTotalManual();
}

/**
 * Tambah barang ke cart dengan optimasi query
 */
private function tambahBarangKeCart($barangId, callable $get, callable $set): void
{
    // Preload barang data dengan select spesifik
    $barang = Barang::select(['id', 'nama', 'stok', 'harga_jual'])
        ->find($barangId);
        
    if (!$barang) {
        Notification::make()
            ->title('Barang tidak ditemukan')
            ->danger()
            ->send();
        return;
    }

    if ($barang->stok <= 0) {
        Notification::make()
            ->title('Stok habis')
            ->body("Stok {$barang->nama} sudah habis")
            ->danger()
            ->send();
        return;
    }

    $items = $get('items') ?? [];
    $existingIndex = $this->cariBarangDiCart($barangId, $items);

    if ($existingIndex !== false) {
        $newQty = $items[$existingIndex]['qty'] + 1;
        
        if ($newQty > $barang->stok) {
            Notification::make()
                ->title('Stok tidak mencukupi')
                ->body("Stok {$barang->nama} hanya {$barang->stok}, tidak cukup untuk {$newQty}")
                ->danger()
                ->send();
            return;
        }

        $items[$existingIndex]['qty'] = $newQty;
        $items[$existingIndex]['total'] = $newQty * $items[$existingIndex]['harga_jual'];
    } else {
        $items[] = [
            'barang_id' => $barang->id,
            'nama_barang' => $barang->nama,
            'qty' => 1,
            'harga_jual' => $barang->harga_jual,
            'total' => $barang->harga_jual,
        ];
    }

    $set('items', $items);
    $set('selected_barang_id', null);
    $this->updateGrandTotalManual();
}

/**
 * Cari barang di cart dengan optimasi
 */
private function cariBarangDiCart($barangId, $items): int|false
{
    foreach ($items as $index => $item) {
        if ($item['barang_id'] == $barangId) {
            return $index;
        }
    }
    return false;
}

/**
 * Hitung subtotal dengan optimasi
 */
private function hitungSubTotal(): float
{
    return collect($this->data['items'] ?? [])
        ->sum('total');
}

/**
 * Hitung grand total dengan optimasi
 */
private function hitungGrandTotal(): float
{
    $subtotal = $this->hitungSubTotal();
    $diskon = max(0, floatval($this->data['diskon'] ?? 0));
    $ppn = max(0, floatval($this->data['ppn'] ?? 0));

    return ($subtotal - $diskon) + $ppn;
}

/**
 * Update grand total dengan optimasi
 */
public function updateGrandTotalManual(): void
{
    $grandTotal = $this->hitungGrandTotal();
    $subtotal = $this->hitungSubTotal();
    
    $this->data['grand_total'] = $grandTotal;
    $this->data['subtotal'] = $subtotal;
    
    // Update kembalian jika bayar sudah diisi
    $bayar = $this->data['bayar'] ?? 0;
    if ($bayar > 0) {
        $this->data['kembalian'] = max(0, $bayar - $grandTotal);
    }
}

/**
 * Simpan transaksi dengan optimasi query dan validation
 */
public function simpanTransaksi(): void
{
    $data = $this->data;
    $items = $data['items'] ?? [];

    // Validasi dasar
    if (empty($data['anggota_id'])) {
        Notification::make()
            ->title('Pilih anggota terlebih dahulu.')
            ->danger()
            ->send();
        return;
    }

    if (empty($items)) {
        Notification::make()
            ->title('Keranjang masih kosong.')
            ->danger()
            ->send();
        return;
    }

    $grandTotal = $this->hitungGrandTotal();
    if (($data['bayar'] ?? 0) < $grandTotal) {
        Notification::make()
            ->title('Pembayaran kurang')
            ->body("Jumlah bayar Rp " . number_format($data['bayar'] ?? 0, 0, ',', '.') . " kurang dari grand total Rp " . number_format($grandTotal, 0, ',', '.'))
            ->danger()
            ->send();
        return;
    }

    // Preload semua barang sekaligus untuk validasi stok
    $barangIds = collect($items)->pluck('barang_id')->unique()->toArray();
    $barangs = Barang::whereIn('id', $barangIds)
        ->get(['id', 'nama', 'stok'])
        ->keyBy('id');

    // Validasi stok dengan data yang sudah di-load
    foreach ($items as $item) {
        if (!isset($item['barang_id'], $item['qty'])) {
            Notification::make()
                ->title('Data barang tidak valid')
                ->danger()
                ->send();
            return;
        }

        $barang = $barangs[$item['barang_id']] ?? null;
        if (!$barang) {
            Notification::make()
                ->title('Barang tidak ditemukan')
                ->body("Barang dengan ID {$item['barang_id']} tidak ditemukan")
                ->danger()
                ->send();
            return;
        }

        if ($barang->stok < $item['qty']) {
            Notification::make()
                ->title('Stok tidak mencukupi')
                ->body("Stok {$barang->nama} hanya {$barang->stok}, tidak cukup untuk {$item['qty']}")
                ->danger()
                ->send();
            return;
        }
    }

    // Simpan transaksi dengan bulk operations
    $penjualan = null;
    DB::transaction(function () use ($data, $items, $grandTotal, $barangs, &$penjualan) {
        // Create penjualan
        $penjualan = Penjualan::create([
            'nomor_nota' => Penjualan::generateNomorNota(),
            'anggota_id' => $data['anggota_id'],
            'tanggal' => now(),
            'total' => $data['subtotal'] ?? 0, 
            'diskon' => $data['diskon'] ?? 0,
            'ppn' => $data['ppn'] ?? 0,
            'grand_total' => $grandTotal,
            'user_id' => Auth::id(),
        ]);

        // Bulk insert penjualan details
        $penjualanDetails = [];
        foreach ($items as $item) {
            if (isset($item['barang_id'], $item['qty'], $item['harga_jual'], $item['total'])) {
                $penjualanDetails[] = [
                    'penjualan_id' => $penjualan->id,
                    'barang_id' => $item['barang_id'],
                    'qty' => $item['qty'],
                    'harga' => $item['harga_jual'],
                    'subtotal' => $item['total'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }
        
        if (!empty($penjualanDetails)) {
            PenjualanDetail::insert($penjualanDetails);
        }

        // Bulk update stok barang
        foreach ($items as $item) {
            if (isset($item['barang_id'], $item['qty'])) {
                Barang::where('id', $item['barang_id'])
                    ->decrement('stok', $item['qty']);
            }
        }
    });

    // Simpan data untuk print
    $this->savedTransactionData = [
        'penjualan' => $penjualan,
        'items' => $items,
        'diskon' => $data['diskon'] ?? 0,
        'ppn' => $data['ppn'] ?? 0,
        'grand_total' => $grandTotal,
        'bayar' => $data['bayar'] ?? 0,
        'kembalian' => $data['kembalian'] ?? 0,
    ];

    Notification::make()
        ->title('Transaksi berhasil disimpan!')
        ->success()
        ->send();
        
    $this->printStrukSetelahSimpan();
}

/**
 * Reset form dengan konfirmasi
 */
public function resetForm(): void
{
    $this->dispatch(
        'confirm-reset',
        message: 'Yakin ingin mereset form? Semua data transaksi akan hilang.',
        onConfirmed: 'performReset'
    );
}

/**
 * Eksekusi reset setelah konfirmasi
 */
public function performReset(): void
{
    $resetData = [
        'anggota_id' => null,
        'selected_barang_id' => null,
        'items' => [],
        'diskon' => 0,
        'ppn' => 0,
        'bayar' => 0,
        'grand_total' => 0,
        'kembalian' => 0,
    ];

    $this->form->fill($resetData);
    $this->data = $resetData;

    Notification::make()
        ->title('Kasir berhasil direset')
        ->body('Semua data transaksi telah dikosongkan')
        ->success()
        ->send();
}

/**
 * Print struk dengan optimasi query
 */
public function printStrukSetelahSimpan(): void
{
    if (!$this->savedTransactionData) {
        Notification::make()
            ->title('Tidak ada data transaksi untuk dicetak')
            ->warning()
            ->send();
        return;
    }

    // Preload data toko dan anggota sekaligus
    $toko = Toko::first();
    if (!$toko) {
        Notification::make()
            ->title('Data toko belum diatur')
            ->warning()
            ->send();
        return;
    }

    $anggota = Anggota::find($this->savedTransactionData['penjualan']->anggota_id);
    $tanggal = $this->savedTransactionData['penjualan']->tanggal;
    
    if (is_string($tanggal)) {
        $tanggal = Carbon::parse($tanggal);
    }

    session([
        'strukData' => [
            'toko' => $toko,
            'anggota' => $anggota,
            'items' => $this->savedTransactionData['items'] ?? [],
            'diskon' => $this->savedTransactionData['diskon'] ?? 0,
            'ppn' => $this->savedTransactionData['ppn'] ?? 0,
            'grand_total' => $this->savedTransactionData['grand_total'] ?? 0,
            'bayar' => $this->savedTransactionData['bayar'] ?? 0,
            'kembalian' => $this->savedTransactionData['kembalian'] ?? 0,
            'tanggal' => $tanggal->format('d/m/Y H:i:s'),
            'kasir' => Auth::user()->name,
            'nomor_nota' => $this->savedTransactionData['penjualan']->nomor_nota,
        ]
    ]);

    $printUrl = route('print.struk-thermal');

    $this->js(<<<JS
        window.open('{$printUrl}', '_blank', 'width=400,height=600');
    JS);

    $this->resetFormSetelahPrint();
}

/**
 * Reset form setelah print
 */
public function resetFormSetelahPrint(): void
{
    $resetData = [
        'anggota_id' => null,
        'selected_barang_id' => null,
        'items' => [],
        'diskon' => 0,
        'ppn' => 0,
        'bayar' => 0,
        'grand_total' => 0,
        'kembalian' => 0,
    ];

    $this->form->fill($resetData);
    $this->data = $resetData;
    $this->savedTransactionData = null;
}

/**
 * Skip print dan reset form
 */
public function skipPrint(): void
{
    $this->resetFormSetelahPrint();
    
    Notification::make()
        ->title('Form telah direset')
        ->success()
        ->send();
}
}
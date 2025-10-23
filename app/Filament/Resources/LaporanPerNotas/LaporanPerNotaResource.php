<?php

namespace App\Filament\Resources\LaporanPerNotas;

use App\Filament\Resources\LaporanPerNotas\Pages\ManageLaporanPerNotas;
use App\Models\Penjualan;
use BackedEnum;
use Filament\Tables\Filters\Filter;
use Filament\Forms\Components\DatePicker;
use Filament\Resources\Resource;
use Carbon\Carbon;
use Filament\Actions\ViewAction;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\Summarizers\Sum;
use Filament\Tables\Columns\Summarizers\Summarizer;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\Indicator;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use UnitEnum;

class LaporanPerNotaResource extends Resource
{
    protected static ?string $model = Penjualan::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedNewspaper;

    protected static string|UnitEnum|null $navigationGroup = 'Laporan';

    protected static ?string $recordTitleAttribute = 'nomor_nota';

    protected static ?string $navigationLabel = 'Laporan Per Nota';

    protected static ?string $title = 'Laporan Per Nota';

    protected static ?string $slug = 'laporan-per-nota';

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with(['barangs']);
    }

    public static function infolist(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Detail Barang')
                    ->schema([
                    Grid::make(4)
                        ->schema([
                        TextEntry::make('nama_barang')
                            ->label('Nama Barang')
                            ->state(function ($record) {
                                $items = $record->barangs;
                                if ($items->isEmpty()) return '-';
                                
                                return $items->pluck('nama')->implode("<br>");
                            })
                            ->html(),
                            
                        TextEntry::make('qty')
                            ->label('Qty')
                            ->state(function ($record) {
                                $items = $record->barangs;
                                if ($items->isEmpty()) return '-';
                                
                                return $items->pluck('qty')->implode("<br>");
                            })
                            ->html(),
                            
                        TextEntry::make('harga')
                            ->label('Harga')
                            ->state(function ($record) {
                                $items = $record->barangs;
                                if ($items->isEmpty()) return '-';
                                
                                return $items->map(function ($item) {
                                    return 'Rp ' . number_format($item->harga, 0, ',', '.');
                                })->implode("<br>");
                            })
                            ->html(),
                            
                        TextEntry::make('subtotal')
                            ->label('Subtotal')
                            ->state(function ($record) {
                                $items = $record->barangs;
                                if ($items->isEmpty()) return '-';
                                
                                return $items->map(function ($item) {
                                    return 'Rp ' . number_format($item->subtotal, 0, ',', '.');
                                })->implode("<br>");
                            })
                            ->html(),
                                
                    ])
                ])
                ->columnSpanFull()
            ]);
    }
        
    public static function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('nomor_nota')
            ->columns([
                TextColumn::make('index')
                    ->label('No.')
                    ->rowIndex()
                    ->width(70)
                    ->grow(false)
                    ->alignCenter(),

                TextColumn::make('nomor_nota')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('anggota.nama')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('total')
                    ->sortable()
                    ->money('IDR')
                    ->summarize(Sum::make()->money('IDR')->label('Jumlah Total')),

                TextColumn::make('diskon')
                    ->sortable()
                    ->money('IDR')
                    ->summarize(Sum::make()->money('IDR')->label('Jumlah Diskon')),

                TextColumn::make('ppn')
                    ->sortable(),

                TextColumn::make('grand_total')
                    ->sortable()
                    ->money('IDR')
                    ->summarize(Sum::make()->money('IDR')->label('Jumlah Grand Total')),

                TextColumn::make('harga_beli')
                    ->label('Modal')
                    ->money('IDR')
                    ->sortable()
                    ->state(function ($record) {
                        return $record->barangs->sum(function ($barang) {
                            return $barang->harga_beli * $barang->qty;
                        });
                    })
                    ->summarize(
                        Summarizer::make()
                            ->label('Total HPP')
                            ->using(function ($livewire) {
                                $query = $livewire->getFilteredTableQuery();
                                
                                $penjualanIds = $query->pluck('id');
                                
                                if ($penjualanIds->isEmpty()) {
                                    return 0;
                                }
                                
                                return DB::table('penjualan_details as pd')
                                    ->join('barangs as b', 'b.id', '=', 'pd.barang_id')
                                    ->whereIn('pd.penjualan_id', $penjualanIds)
                                    ->selectRaw('SUM(b.harga_beli * pd.qty) as total_hpp')
                                    ->value('total_hpp') ?? 0;
                            })
                            ->money('IDR')
                    ),

                TextColumn::make('tanggal')
                    ->date('j M Y')
                    ->sortable()
                    ->summarize(
                        Summarizer::make()
                            ->label('Total Laba Bersih')
                            ->using(function ($livewire) {
                                $query = $livewire->getFilteredTableQuery();
                                
                                $penjualanIds = $query->pluck('id');
                                
                                if ($penjualanIds->isEmpty()) {
                                    return 0;
                                }
                                
                                $totalPenjualan = DB::table('penjualans')
                                    ->whereIn('id', $penjualanIds)
                                    ->sum('grand_total');
                                
                                $totalHpp = DB::table('penjualan_details as pd')
                                    ->join('barangs as b', 'b.id', '=', 'pd.barang_id')
                                    ->whereIn('pd.penjualan_id', $penjualanIds)
                                    ->selectRaw('SUM(b.harga_beli * pd.qty) as total_hpp')
                                    ->value('total_hpp') ?? 0;
                                
                                return $totalPenjualan - $totalHpp;
                            })
                            ->money('IDR')
                    ),

                TextColumn::make('user.name')
                    ->label('Kasir')
                    ->searchable()
                    ->sortable(),
            ])
            ->defaultSort('tanggal', direction: 'desc')
            ->filters([
                Filter::make('periode')
                    ->schema([
                        DatePicker::make('dari_tanggal')
                            ->label('Tangal Awal')
                            ->default(now()->toDateString()),
                        DatePicker::make('sampai_tanggal')
                            ->label('Tanggal Akhir')
                            ->default(now()->toDateString()),
                    ])

                    ->query(function (Builder $query, array $data): Builder {
                        return $query
                            ->when(
                                $data['dari_tanggal'],
                                fn (Builder $query, $date): Builder => $query->whereDate('tanggal', '>=', $date),
                            )
                            ->when(
                                $data['sampai_tanggal'],
                                fn (Builder $query, $date): Builder => $query->whereDate('tanggal', '<=', $date),
                            );
                    })
                    
                    ->indicateUsing(function (array $data): array {
                        $indicators = [];

                        if ($data['dari_tanggal'] ?? null) {
                            $indicators[] = Indicator::make('Mulai tanggal ' . Carbon::parse($data['dari_tanggal'])->locale('id')->translatedFormat('d M Y'))
                                ->removeField('dari_tanggal');
                        }

                        if ($data['sampai_tanggal'] ?? null) {
                            $indicators[] = Indicator::make('Sampai tanggal ' . Carbon::parse($data['sampai_tanggal'])->locale('id')->translatedFormat('d M Y'))
                                ->removeField('sampai_tanggal');
                        }

                        return $indicators;
                    })  
            ])
            ->recordActions([
                ViewAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ManageLaporanPerNotas::route('/'),
        ];
    }
}

<?php

namespace App\Filament\Resources\LaporanPerItems;

use App\Filament\Resources\LaporanPerItems\Pages\ManageLaporanPerItems;
use App\Models\PenjualanDetail;
use BackedEnum;
use Carbon\Carbon;
use Filament\Forms\Components\DatePicker;
use Filament\Resources\Resource;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\Summarizers\Sum;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Filters\Indicator;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use UnitEnum;

class LaporanPerItemResource extends Resource
{
    protected static ?string $model = PenjualanDetail::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedNewspaper;

    protected static string|UnitEnum|null $navigationGroup = 'Laporan';

    protected static ?string $navigationLabel = 'Laporan Per Item';

    protected static ?string $title = 'Laporan Per Item';

    protected static ?string $slug = 'laporan-per-item';

    protected static ?string $recordTitleAttribute = 'barang_id';

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('barang.nama')
                    ->searchable()
                    ->label('Nama Barang'),

                TextColumn::make('qty')
                    ->summarize(Sum::make()->label('')),

                TextColumn::make('subtotal')
                    ->summarize(Sum::make()->prefix('Rp. ')->label('')),
            ])
            ->defaultGroup('barang.nama')
            ->groupsOnly()
            ->filters([
                Filter::make('periode')
                    ->schema([
                        DatePicker::make('dari_tanggal')
                            ->label('Tanggal Awal')
                            ->default(now()->toDateString()),
                        DatePicker::make('sampai_tanggal')
                            ->label('Tanggal Akhir')
                            ->default(now()->toDateString()),
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        return $query
                            ->when(
                                $data['dari_tanggal'],
                                fn (Builder $query, $date): Builder => $query->whereDate('penjualan_details.created_at', '>=', $date),
                            )
                            ->when(
                                $data['sampai_tanggal'],
                                fn (Builder $query, $date): Builder => $query->whereDate('penjualan_details.created_at', '<=', $date),
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
                ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ManageLaporanPerItems::route('/'),
        ];
    }
}

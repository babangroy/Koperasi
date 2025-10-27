<?php

namespace App\Filament\Widgets;

use App\Filament\Resources\LaporanPerItems\Pages\ManageLaporanPerItems;
use App\Filament\Resources\LaporanPerNotas\Pages\ManageLaporanPerNotas;
use App\Models\Penjualan;
use App\Models\PenjualanDetail;
use Filament\Support\Colors\Color;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class PenjualanWidget extends StatsOverviewWidget
{
    protected static bool $isLazy = false;
    protected function getStats(): array
    {
        $penjualanHariIni = PenjualanDetail::whereDate('created_at', today())->sum('qty');
        $GrandHariIni = Penjualan::whereDate('created_at', today())->sum('grand_total');
        $LabaHariIni = Penjualan::getLaba()
            ->whereDate('a.created_at', today())
            ->get()
            ->sum('laba');
        
        return [
            Stat::make('Item',$penjualanHariIni)
                ->description('Item terjual hari ini')
                ->descriptionIcon('heroicon-o-shopping-bag')    
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color(Color::Amber)
                ->url(ManageLaporanPerItems::getUrl()),

            Stat::make('Pendapatan', 'Rp. ' . number_format($GrandHariIni, 0, ',', '.'))
                ->description('Pendapatan hari ini')
                ->descriptionIcon('heroicon-o-credit-card')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color(Color::Indigo)
                ->url(ManageLaporanPerNotas::getUrl()),

            Stat::make('Laba', 'Rp. ' . number_format($LabaHariIni, 0, ',', '.'))
                ->description('Laba bersih hari ini')
                ->descriptionIcon('heroicon-o-currency-dollar')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color(Color::Emerald)
                ->url(ManageLaporanPerNotas::getUrl()),
        ];
    }
}

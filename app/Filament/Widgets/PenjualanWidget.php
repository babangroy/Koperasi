<?php

namespace App\Filament\Widgets;

use App\Models\Penjualan;
use App\Models\PenjualanDetail;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class PenjualanWidget extends StatsOverviewWidget
{
    protected static bool $isLazy = false;
    protected function getStats(): array
    {
        $penjualanHariIni = PenjualanDetail::whereDate('created_at', today())->count();
        $GrandHariIni = Penjualan::whereDate('created_at', today())->sum('grand_total');
        $LabaHariIni = Penjualan::getLaba()
            ->whereDate('a.created_at', today())
            ->get()
            ->sum('laba');
        
        return [
            Stat::make('Barang terjual Hari Ini', $penjualanHariIni)
                ->description('Jumlah barang terjual')
                ->descriptionIcon('heroicon-o-shopping-bag')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('success'),

            Stat::make('Total terjual Hari Ini', 'Rp. ' . number_format($GrandHariIni, 0, ',', '.'))
                ->description('Pendapatan hari ini')
                ->descriptionIcon('heroicon-o-shopping-bag')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('success'),

            Stat::make('Laba Hari Ini', 'Rp. ' . number_format($LabaHariIni, 0, ',', '.'))
                ->description('Laba bersih hari ini')
                ->descriptionIcon('heroicon-o-shopping-bag')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('success'),
        ];
    }
}

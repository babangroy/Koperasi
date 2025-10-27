<?php

namespace App\Filament\Widgets;

use App\Models\Penjualan;
use Filament\Widgets\ChartWidget;
use Flowframe\Trend\Trend;
use Flowframe\Trend\TrendValue;

class GrandTotalChart extends ChartWidget
{
    protected static bool $isLazy = false;
    protected static ?int $sort = 3;
    protected bool $isCollapsible = true;
    protected ?string $heading = 'Grafik Pendapatan';

    protected function getFilters(): ?array
    {
        return [
            'daily' => 'Per Hari',
            'weekly' => 'Per Minggu',
            'monthly' => 'Per Bulan',
        ];
    }

    protected function getData(): array
    {
        $filter = $this->filter ?? 'daily';

        switch ($filter) {

            case 'monthly':
                $data = Trend::model(Penjualan::class)
                    ->between(
                        start: now()->startOfYear(),
                        end: now()->endOfYear(),
                    )
                    ->perMonth()
                    ->sum('grand_total');
                break;

            case 'weekly':
                $data = Trend::model(Penjualan::class)
                    ->between(
                        start: now()->startOfMonth(),
                        end: now()->endOfMonth(),
                    )
                    ->perWeek()
                    ->sum('grand_total');
                break;

            case 'daily':
            default:
                $data = Trend::model(Penjualan::class)
                    ->between(
                        start: now()->startOfWeek(),
                        end: now()->endOfWeek(),
                    )
                    ->perDay()
                    ->sum('grand_total');
                break;
        }

        return [
            'datasets' => [
                [
                    'label' => 'Pendapatan',
                    'data' => $data->map(fn (TrendValue $value) => $value->aggregate),
                    'borderColor' => '#3b82f6',
                    'backgroundColor' => 'rgba(59, 130, 246, 0.1)',
                    'fill' => true,
                    'tension' => 0.3,
                ],
            ],
            'labels' => $data->map(fn (TrendValue $value) => $value->date),
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}

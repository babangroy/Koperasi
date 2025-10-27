<?php

namespace App\Filament\Widgets;

use App\Models\PenjualanDetail;
use Filament\Forms\Components\DatePicker;
use Filament\Schemas\Schema;
use Filament\Widgets\ChartWidget;
use Flowframe\Trend\Trend;
use Flowframe\Trend\TrendValue;

class ItemsChart extends ChartWidget
{
    protected static bool $isLazy = false;
    protected static ?int $sort = 2;
    protected bool $isCollapsible = true;
    protected ?string $heading = 'Grafik Item Terjual';

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
                $data = Trend::model(PenjualanDetail::class)
                    ->between(
                        start: now()->startOfYear(),
                        end: now()->endOfYear(),
                    )
                    ->perMonth()
                    ->sum('qty');
                break;

            case 'weekly':
                $data = Trend::model(PenjualanDetail::class)
                    ->between(
                        start: now()->startOfMonth(),
                        end: now()->endOfMonth(),
                    )
                    ->perWeek()
                    ->sum('qty');
                break;

            case 'daily':
            default:
                $data = Trend::model(PenjualanDetail::class)
                    ->between(
                        start: now()->startOfWeek(),
                        end: now()->endOfWeek(),
                    )
                    ->perDay()
                    ->sum('qty');
                break;
        }

        return [
            'datasets' => [
                [
                    'label' => 'Item',
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

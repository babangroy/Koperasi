<?php

namespace App\Filament\Resources\LaporanPerNotas\Pages;

use App\Filament\Resources\LaporanPerNotas\LaporanPerNotaResource;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Filament\Actions\Action;
use Filament\Resources\Pages\ManageRecords;

class ManageLaporanPerNotas extends ManageRecords
{
    protected static string $resource = LaporanPerNotaResource::class;
    protected static ?string $title = 'Laporan Per Nota';

    protected function getHeaderActions(): array
    {
        return [
            Action::make('exportPdf')
                ->label('Export PDF')
                ->icon('heroicon-o-document-arrow-down')
                ->action(function ($livewire) {
                    $query = $this->getResource()::getEloquentQuery();

                    if (method_exists($livewire, 'getFilteredTableQuery')) {
                        $query = $livewire->getFilteredTableQuery();
                    }

                    $records = $query->get();
                    $periode = 'Semua Periode';
                    $filters = $livewire->tableFilters ?? [];

                    $dari = $filters['periode']['dari_tanggal'] ?? null;
                    $sampai = $filters['periode']['sampai_tanggal'] ?? null;

                    if ($dari && $sampai) {
                        $periode = Carbon::parse($dari)
                            ->locale('id')
                            ->translatedFormat('j M Y')
                            . ' - ' .
                            Carbon::parse($sampai)
                            ->locale('id')
                            ->translatedFormat('j M Y');
                    } elseif ($dari && !$sampai) {
                        $periode = 'Mulai ' . Carbon::parse($dari)
                            ->locale('id')
                            ->translatedFormat('j M Y');
                    } elseif (!$dari && $sampai) {
                        $periode = 'Sampai ' . Carbon::parse($sampai)
                            ->locale('id')
                            ->translatedFormat('j M Y');
                    }

                    $pdf = Pdf::loadView('exports.nota-penjualan-pdf', [
                        'records' => $records,
                        'periode' => $periode,
                    ])->setPaper('a4', 'landscape');

                    return response()->streamDownload(
                        fn() => print($pdf->output()),
                        'laporan-penjualan-' . date('Y-m-d-His') . '.pdf'
                    );
                }),
        ];
    }
}

<?php

namespace App\Filament\Resources\LaporanPerItems\Pages;

use App\Filament\Resources\LaporanPerItems\LaporanPerItemResource;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Filament\Actions\Action;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManageLaporanPerItems extends ManageRecords
{
    protected static string $resource = LaporanPerItemResource::class;

    protected function getHeaderActions(): array
    {
        return [
            // CreateAction::make(),
            Action::make('exportPdf')
                ->label('Export PDF')
                ->icon('heroicon-o-document-arrow-down')
                ->action(function ($livewire) {
                    $query = $this->getResource()::getEloquentQuery();
                    
                    if (method_exists($livewire, 'getFilteredTableQuery')) {
                        $query = $livewire->getFilteredTableQuery();
                    }

                    $records = $query->selectRaw('
                            barangs.kode as kode_barang,
                            barangs.nama as nama_barang,
                            SUM(penjualan_details.qty) as jumlah,
                            SUM(penjualan_details.subtotal) as total_subtotal
                        ')
                        ->join('barangs', 'penjualan_details.barang_id', '=', 'barangs.id')
                        ->groupBy('barangs.id', 'barangs.kode', 'barangs.nama')
                        ->orderBy('barangs.nama', 'asc')
                        ->get();

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

                    $pdf = Pdf::loadView('exports.item-penjualan-pdf', [
                        'records' => $records,
                        'periode' => $periode,
                    ])->setPaper('a4', 'portrait');

                    return response()->streamDownload(
                        fn() => print($pdf->output()),
                        'laporan-penjualan-' . date('Y-m-d-His') . '.pdf'
                    );
                }),
        ];
    }
}

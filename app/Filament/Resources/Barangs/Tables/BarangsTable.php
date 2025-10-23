<?php

namespace App\Filament\Resources\Barangs\Tables;

use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class BarangsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('index')
                    ->label('No.')
                    ->rowIndex()
                    ->width(70)
                    ->grow(false)
                    ->alignCenter(), 
                TextColumn::make('kode')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('nama')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('kategori.nama')
                    ->label('Kategori')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('merek')
                    ->searchable(),
                TextColumn::make('harga_beli')
                    ->prefix('Rp. ')
                    ->numeric(),
                TextColumn::make('harga_jual')
                    ->prefix('Rp. ')    
                    ->numeric(),
                TextColumn::make('satuan.nama')
                    ->label('Satuan')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('stok')
                    ->badge()
                    ->color(function ($state) {
                        if ($state == 0) {
                            return 'danger';
                        } elseif ($state >= 1 && $state <= 15) {
                            return 'warning';
                        } else {
                            return 'success';
                        }
                    })
                    ->sortable(),
            ])
            ->filters([
                //
            ])
            ->recordUrl(null)
            ->recordActions([
                EditAction::make(),
                DeleteAction::make(),
            ]);
    }
}

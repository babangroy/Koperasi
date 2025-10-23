<?php

namespace App\Filament\Resources\Satuans\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class SatuansTable
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
                TextColumn::make('nama')
                    ->searchable()
                    ->sortable(),
            ])
            ->filters([
                //
            ])
            ->recordUrl(null)
            ->recordActions([
                EditAction::make()
                    ->modalHeading('Edit Satuan')
                    ->modalSubheading('Ubah data satuan di sini')
                    ->modalButton('Simpan')
                    ->modalWidth('md'), // <-- custom ukuran modal
                DeleteAction::make(),
            ]);
    }
}

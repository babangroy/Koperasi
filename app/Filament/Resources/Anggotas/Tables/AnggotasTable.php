<?php

namespace App\Filament\Resources\Anggotas\Tables;

use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class AnggotasTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('index')
                    ->label('No.')
                    ->rowIndex(),
                TextColumn::make('nik')
                    ->label('NIK')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('nama')
                    ->label('Nama')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('nrp')
                    ->label('NRP')
                    ->searchable(),
                TextColumn::make('alamat')
                    ->label('Alamat'),
                TextColumn::make('telepon')
                    ->label('No Telepon'),
                TextColumn::make('jenis_kelamin')
                    ->label('Jenis Kelamin'),
                TextColumn::make('status')
                    ->label('Status')
                    ->sortable()
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                            'Aktif' => 'success',
                            'Tidak Aktif' => 'danger',
                            default => 'secondary',
                        }),
                TextColumn::make('created_at')
                    ->label('Tanggal Daftar')
                    ->dateTime('d/m/Y')
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

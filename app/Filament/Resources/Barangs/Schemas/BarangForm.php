<?php

namespace App\Filament\Resources\Barangs\Schemas;

use App\Models\Barang;
use App\Models\Kategori;
use App\Models\Satuan;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;
use Filament\Support\RawJs;

class BarangForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([

                TextInput::make('nama')
                    ->label('Nama Barang')
                    ->required(),

                Select::make('id_kategori')
                    ->label('Kategori')
                    ->options(Kategori::query()->pluck('nama', 'id')->toArray())
                    ->searchable()
                    ->preload()
                    ->required(),

                TextInput::make('merek')
                    ->label('Merek')
                    ->maxLength(100),

                TextInput::make('harga_beli')
                    ->label('Harga Beli')
                    ->mask(RawJs::make('$money($input)'))
                    ->stripCharacters(',')
                    ->numeric()
                    ->prefix('Rp')
                    ->default(0)
                    ->required(),

                TextInput::make('harga_jual')
                    ->label('Harga Jual')
                    ->mask(RawJs::make('$money($input)'))
                    ->stripCharacters(',')
                    ->numeric()
                    ->prefix('Rp')
                    ->default(0)
                    ->required(),

                Select::make('id_satuan')
                    ->label('Satuan')
                    ->options(Satuan::query()->pluck('nama', 'id')->toArray())
                    ->searchable()
                    ->required(),

                TextInput::make('stok')
                    ->label('Stok')
                    ->numeric()
                    ->default(0)
                    ->required(),
            ]);
    }
}

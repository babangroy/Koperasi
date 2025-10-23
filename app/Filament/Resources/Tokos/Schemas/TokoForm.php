<?php

namespace App\Filament\Resources\Tokos\Schemas;

use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class TokoForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nama')
                    ->required(),
                TextInput::make('alamat')
                    ->required(),
                TextInput::make('telepon')
                    ->tel()
                    ->rule('regex:/^[0-9]+$/')
                    ->maxLength(13)
                    ->validationMessages
                        ([
                        'regex' => 'Telepon hanya boleh berisi angka (tanpa huruf atau simbol).',
                        ])
                    ->required(),
                TextInput::make('pemilik')
                    ->required(),
            ]);
    }
}

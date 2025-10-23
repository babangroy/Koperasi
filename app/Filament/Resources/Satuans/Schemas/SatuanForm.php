<?php

namespace App\Filament\Resources\Satuans\Schemas;

use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class SatuanForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nama')
                    ->required()
                    ->columnSpan('full'),
            ]);
    }
}

<?php

namespace App\Filament\Resources\Anggotas\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class AnggotaForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('nik')
                    ->label('NIK')
                    ->maxLength(16)
                    ->unique(ignoreRecord: true) 
                    ->required()
                    ->rule('regex:/^[0-9]+$/')
                    ->validationMessages
                        ([
                        'regex' => 'NIK hanya boleh berisi angka (tanpa huruf atau simbol).',
                        'unique' => 'NIK sudah terdaftar.',
                        ]),
                TextInput::make('nama')
                    ->label('Nama')
                    ->required(),
                TextInput::make('nrp')
                    ->label('NRP')
                    ->unique(ignoreRecord: true)
                    ->validationMessages
                        ([
                        'unique' => 'NRP sudah terdaftar.',
                        ])
                    ->required(),
                Textarea::make('alamat')
                    ->label('Alamat')
                    ->required(),
                TextInput::make('telepon')
                    ->label('No Telepon')
                    ->maxLength(13)
                    ->required()
                    ->tel(),
                Select::make('jenis_kelamin')
                    ->label('Jenis Kelamin')
                    ->options(['Laki-laki' => 'Laki laki', 'Perempuan' => 'Perempuan'])
                    ->required(),
                Select::make('status')
                    ->label('Status')
                    ->options(['Aktif' => 'Aktif', 'Tidak Aktif' => 'Tidak aktif'])
                    ->required(),
            ]);
    }
}

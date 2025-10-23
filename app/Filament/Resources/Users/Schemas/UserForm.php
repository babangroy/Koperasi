<?php

namespace App\Filament\Resources\Users\Schemas;

use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;
use Illuminate\Support\Facades\Hash;

class UserForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->schema([
                TextInput::make('name')
                    ->label('Nama')
                    ->required()
                    ->maxLength(255)
                    ->autocomplete('off'),
                    
                TextInput::make('username')
                    ->label('Username')
                    ->unique('users', 'username', ignoreRecord: true)
                    ->validationMessages([
                        'unique' => 'Username sudah terdaftar.',
                    ])
                    ->autocomplete('off')
                    ->required()
                    ->maxLength(255),
                    
                TextInput::make('email')
                    ->label('Email')
                    ->unique('users', 'email', ignoreRecord: true)
                    ->validationMessages([
                        'unique' => 'Email sudah terdaftar.',
                    ])
                    ->email()
                    ->required()
                    ->maxLength(255)
                    ->autocomplete('off'),
                    
                TextInput::make('password')
                    ->password()
                    ->autocomplete('new-password')
                    ->required(fn ($context) => $context === 'create')
                    ->minLength(8)
                    ->dehydrated(fn ($state) => filled($state))
                    ->dehydrateStateUsing(fn ($state) => filled($state) ? Hash::make($state) : null)
                    ->helperText(fn ($context) => $context === 'edit' ? 'Kosongkan jika tidak ingin mengubah password' : ''),
            ]);
    }
}

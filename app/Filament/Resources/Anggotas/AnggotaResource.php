<?php

namespace App\Filament\Resources\Anggotas;

use App\Filament\Resources\Anggotas\Pages\CreateAnggota;
use App\Filament\Resources\Anggotas\Pages\EditAnggota;
use App\Filament\Resources\Anggotas\Pages\ListAnggotas;
use App\Filament\Resources\Anggotas\Schemas\AnggotaForm;
use App\Filament\Resources\Anggotas\Tables\AnggotasTable;
use App\Models\Anggota;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;
use UnitEnum;

class AnggotaResource extends Resource
{
    protected static ?string $model = Anggota::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedUserGroup;

    protected static string|UnitEnum|null $navigationGroup = 'Master Data';


    protected static ?string $recordTitleAttribute = 'nama';

    public static function getNavigationBadge(): ?string
    {
        return Anggota::getModel()::count();
    }

    public static function form(Schema $schema): Schema
    {
        return AnggotaForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return AnggotasTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListAnggotas::route('/'),
            'create' => CreateAnggota::route('/create'),
            'edit' => EditAnggota::route('/{record}/edit'),
        ];
    }
}

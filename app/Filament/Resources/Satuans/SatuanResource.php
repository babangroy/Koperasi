<?php

namespace App\Filament\Resources\Satuans;

use App\Filament\Resources\Satuans\Pages\ListSatuans;
use App\Filament\Resources\Satuans\Schemas\SatuanForm;
use App\Filament\Resources\Satuans\Tables\SatuansTable;
use App\Models\Satuan;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;
use UnitEnum;

class SatuanResource extends Resource 
{
    protected static ?string $model = Satuan::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::Tag;

    protected static string|UnitEnum|null $navigationGroup = 'Master Data';

    protected static ?string $recordTitleAttribute = 'nama';

    public static function form(Schema $schema): Schema
    {
        return SatuanForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return SatuansTable::configure($table);
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
            'index' => ListSatuans::route('/'),
            // 'create' => CreateSatuan::route('/create'),
            // 'edit' => EditSatuan::route('/{record}/edit'),
        ];
    }
}

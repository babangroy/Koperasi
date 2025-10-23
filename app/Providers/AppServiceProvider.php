<?php

namespace App\Providers;

use Carbon\Carbon;
use Filament\Forms\Components\TextInput;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        TextInput::configureUsing(function (TextInput $component) {
            $component->autocomplete('off');
        });
        Carbon::setLocale('id');
    }
}

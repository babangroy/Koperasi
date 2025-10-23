<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/print/struk-thermal', function () {
    $data = session('strukData');
    if (!$data) {
        abort(404, 'Data struk tidak ditemukan');
    }
    session()->forget('strukData');
    return view('prints.struk-thermal', $data);
})->name('print.struk-thermal');

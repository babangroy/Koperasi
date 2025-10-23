<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LaporanPerNota extends Model
{
    protected $guarded = [];
    
    // Optional: Non-aktifkan timestamps
    public $timestamps = false;
    
    public static function getLaporanData($filters = [])
    {
        return Penjualan::with('item')
            ->whereBetween('tanggal', [$filters['start'], $filters['end']])
            ->get()
            ->groupBy('item_id');
    }
}

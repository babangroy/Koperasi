<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Penjualan extends Model
{
    use HasFactory;

    protected $fillable = [
        'nomor_nota',
        'anggota_id',
        'tanggal',
        'total',
        'diskon',
        'ppn',
        'grand_total',
        'user_id',
    ];

    protected $dates = ['tanggal'];

    public function anggota()
    {
        return $this->belongsTo(Anggota::class, 'anggota_id');
    }

    public function details()
    {
        return $this->hasMany(PenjualanDetail::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function barangs()
    {
        return $this->hasManyThrough(
            Barang::class,      
            PenjualanDetail::class, 
            'penjualan_id',        
            'id',                 
            'id',
            'barang_id'
        )->select('barangs.id', 'barangs.nama','barangs.harga_beli as harga_beli', 'penjualan_details.qty', 'penjualan_details.harga', 'penjualan_details.subtotal as subtotal');
    }

    public function getJumlahItemAttribute()
    {
        return $this->details()->sum('qty');
    }

    public static function generateNomorNota(): string
    {
        $prefix = 'KSR-' . now()->format('Ymd') . '-';
        $countToday = static::whereDate('tanggal', now()->toDateString())->count() + 1;
        $number = str_pad($countToday, 4, '0', STR_PAD_LEFT);
        return $prefix . $number;
    }

    public static function getLaba()
    {
        return DB::table('penjualans as a')
            ->selectRaw('a.*, 
                (a.grand_total - COALESCE(
                    (SELECT SUM(b.qty * c.harga_beli) 
                     FROM penjualan_details b 
                     LEFT JOIN barangs c ON b.barang_id = c.id 
                     WHERE b.penjualan_id = a.id
                     GROUP BY b.penjualan_id), 0
                )) as laba'
            );
    }

}
 
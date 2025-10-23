<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

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

}
 
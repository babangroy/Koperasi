<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Barang extends Model
{
    use HasFactory;

    protected $fillable = [
        'kode',
        'nama',
        'id_kategori',
        'merek',
        'harga_beli',
        'harga_jual',
        'id_satuan',
        'stok',
    ];
    
    public function kategori()
    {
        return $this->belongsTo(Kategori::class, 'id_kategori');
    }

    public function satuan()
    {
        return $this->belongsTo(Satuan::class, 'id_satuan');
    }

    public function penjualanDetails()
    {
        return $this->hasMany(PenjualanDetail::class, 'barang_id');
    }

    protected static function booted()
    {
        static::creating(function ($barang) {
            if (empty($barang->kode)) {
                $lastKode = static::max('kode');
                $nextNumber = $lastKode ? ((int) filter_var($lastKode, FILTER_SANITIZE_NUMBER_INT)) + 1 : 1;
                $barang->kode = 'BRG' . str_pad($nextNumber, 4, '0', STR_PAD_LEFT);
            }
        });
    }

    public function scopeAvailable(Builder $query): Builder
    {
        return $query->where('stok', '>', 0)->where('status', 'aktif');
    }

    protected $casts = ['harga_jual' => 'decimal:2', 'stok' => 'integer'];

}

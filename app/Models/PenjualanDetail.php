<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class PenjualanDetail extends Model
{
    use HasFactory;

    protected $fillable = [
        'penjualan_id',
        'barang_id',
        'qty',
        'harga',
        'subtotal',
    ];

    public function penjualan()
    {
        return $this->belongsTo(Penjualan::class, 'penjualan_id');
    }

    public function barang()
    {
        return $this->belongsTo(Barang::class, 'barang_id');
    }
    
    public function scopeTotalQtyPerBarang($query)
    {
        return $query->select(
            'penjualan_details.barang_id',
            'barangs.kode',
            'barangs.nama',
            DB::raw('SUM(penjualan_details.qty) as total_qty')
        )
        ->join('barangs', 'penjualan_details.barang_id', '=', 'barangs.id')
        ->groupBy('penjualan_details.barang_id', 'barangs.kode', 'barangs.nama')
        ->orderByDesc('total_qty');
    }
}

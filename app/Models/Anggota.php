<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Anggota extends Model
{
    use HasFactory;

    protected $fillable = [
        'nik',
        'nama',
        'nrp',
        'alamat',
        'telepon',
        'jenis_kelamin',
        'status',
    ];

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', 'aktif');
    }
}

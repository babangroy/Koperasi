<?php

namespace App\Models;

<<<<<<< HEAD
=======
// use Illuminate\Contracts\Auth\MustVerifyEmail;

>>>>>>> 88aa2af (Pesan perubahan kamu di sini)
use Filament\Models\Contracts\FilamentUser;
use Filament\Panel;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable implements FilamentUser
{
    use HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'username',
        'email',
        'password',
    ];

    public function username()
    {
        return 'username';
    }

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

<<<<<<< HEAD
    /**
     * Izinkan semua user untuk mengakses semua panel Filament.
     */
=======
>>>>>>> 88aa2af (Pesan perubahan kamu di sini)
    public function canAccessPanel(Panel $panel): bool
    {
        return true;
    }
}

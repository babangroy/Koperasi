<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Struk Transaksi</title>
    <style>
        @media print {
            @page {
                size: 80mm 200mm;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'Courier New', monospace;
                font-size: 12px;
                width: 80mm;
                margin: 0;
                padding: 5mm;
                line-height: 1.2;
            }
            .text-center { text-align: center; }
            .text-right { text-align: right; }
            .bold { font-weight: bold; }
            .divider { 
                border-top: 1px dashed #000; 
                margin: 5px 0; 
            }
            table { 
                width: 100%; 
                border-collapse: collapse; 
            }
            th, td { 
                padding: 2px 0; 
                vertical-align: top;
            }
            .item-name { width: 55%; }
            .item-qty { width: 10%; text-align: center; }
            .item-price { width: 35%; text-align: right; }
            .no-print { display: none; }
        }
        body {
            font-family: 'Courier New', monospace;
            font-size: 12px;
            width: 80mm;
            margin: 0;
            padding: 5mm;
            line-height: 1.2;
        }
        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .bold { font-weight: bold; }
        .divider { 
            border-top: 1px dashed #000; 
            margin: 5px 0; 
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
        }
        th, td { 
            padding: 2px 0; 
            vertical-align: top;
        }
        .item-name { width: 55%; }
        .item-qty { width: 10%; text-align: center; }
        .item-price { width: 35%; text-align: right; }
        .no-print { display: none; }
    </style>
</head>
<body>
    <div class="text-center">
        <div class="bold">{{ strtoupper($toko->nama) }}</div>
        <div>{{ $toko->alamat }}</div>
        <div>Telp: {{ $toko->telepon }}</div>
    </div>
    
    <div class="divider"></div>
    
    <table>
        <tr>
            <td>No. Nota</td>
            <td class="text-right">{{ $nomor_nota }}</td>
        </tr>
        <tr>
            <td>Tanggal</td>
            <td class="text-right">{{ $tanggal }}</td>
        </tr>
        <tr>
            <td>Anggota</td>
            <td class="text-right">{{ $anggota->nama ?? 'Umum' }}</td>
        </tr>
        <tr>
            <td>Kasir</td>
            <td class="text-right">{{ $kasir }}</td>
        </tr>
    </table>
    
    <div class="divider"></div>
    
    <table>
        <thead>
            <tr>
                <th class="item-name">Barang</th>
                <th class="item-qty">Qty</th>
                <th class="item-price">Total</th>
            </tr>
        </thead>
        <tbody>
            @foreach($items as $item)
            <tr>
                <td class="item-name">{{ $item['nama_barang'] }}</td>
                <td class="item-qty">{{ $item['qty'] }}</td>
                <td class="item-price">Rp {{ number_format($item['total'], 0, ',', '.') }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>
    
    <div class="divider"></div>
    
    <table>
        <tr>
            <td>Subtotal:</td>
            <td class="text-right">Rp {{ number_format(array_sum(array_column($items, 'total')), 0, ',', '.') }}</td>
        </tr>
        @if($diskon > 0)
        <tr>
            <td>Diskon:</td>
            <td class="text-right">- Rp {{ number_format($diskon, 0, ',', '.') }}</td>
        </tr>
        @endif
        @if($ppn > 0)
        <tr>
            <td>PPN:</td>
            <td class="text-right">+ Rp {{ number_format($ppn, 0, ',', '.') }}</td>
        </tr>
        @endif
        <tr class="bold">
            <td>Grand Total:</td>
            <td class="text-right">Rp {{ number_format($grand_total, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <td>Bayar:</td>
            <td class="text-right">Rp {{ number_format($bayar, 0, ',', '.') }}</td>
        </tr>
        <tr>
            <td>Kembalian:</td>
            <td class="text-right">Rp {{ number_format($kembalian, 0, ',', '.') }}</td>
        </tr>
    </table>
    
    <div class="divider"></div>
    
    <div class="text-center">
        <div>Terima kasih atas kunjungan Anda</div>
        <div class="bold" style="font-size: 10px; margin-top: 3px;">
            *** BARANG SUDAH DIBELI TIDAK DAPAT DIKEMBALIKAN ***
        </div>
    </div>

    {{-- <!-- Tombol untuk testing (akan hilang saat print) -->
    <div class="no-print" style="margin-top: 20px; text-align: center;">
        <button onclick="window.print()" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
            🖨️ Print Struk
        </button>
        <button onclick="window.close()" style="padding: 10px 20px; background: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px;">
            ❌ Tutup
        </button>
    </div> --}}

    <script>
        window.onload = function() {
            // Auto print setelah 500ms
            setTimeout(function() {
                window.print();
            }, 500);

            // Auto close setelah print (optional)
            window.onafterprint = function() {
                setTimeout(function() {
                    window.close();
                }, 1000);
            };
        };
    </script>
</body>
</html>
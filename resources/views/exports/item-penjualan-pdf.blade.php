<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Laporan Penjualan Per Item</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            font-size: 12px; 
            margin: 15px;
        }
        .header { 
            text-align: center; 
            margin-bottom: 30px;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        .header h1 { 
            margin: 0; 
            font-size: 20px; 
            color: #333;
        }
        .header p {
            margin: 5px 0 0 0;
            color: #666;
        }
        .table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 15px;
        }
        .table th, .table td { 
            border: 1px solid #ddd; 
            padding: 8px;
        }
        .table th { 
            background-color: #f8f9fa; 
            font-weight: bold;
            color: #333;
        }
        .table tbody tr:nth-child(even) { 
            background-color: #f9f9f9; 
        }
        .text-right { 
            text-align: right; 
        }
        .text-center { 
            text-align: center; 
            vertical-align: middle;
        }
        .footer {
            margin-top: 5px;
            text-align: right;
            font-size: 10px;
            color: #666;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>LAPORAN PENJUALAN PER ITEM</h1>
        <p>Periode: {{ $periode }}</p>
    </div>

    @if($records->count() > 0)
        <table class="table">
            <thead>
                <tr>
                    <th width="30" class="text-center">No.</th>
                    <th width="90" class="text-center">Kode Barang</th>
                    <th class="text-center">Nama Barang</th>
                    <th class="text-center">Jumlah</th>
                    <th class="text-center">Sub Total</th>
                </tr>
            </thead>
            <tbody>
                @foreach($records as $index => $record)
                <tr>
                    <td class="text-center">{{ $index + 1 }}</td>
                    <td class="text-center">{{ $record->kode_barang }}</td>
                    <td class="text-left">{{ $record->nama_barang }}</td>
                    <td class="text-center">{{ number_format($record->jumlah, 0, ',', '.') }}</td>
                    <td class="text-right">Rp {{ number_format($record->total_subtotal, 0, ',', '.') }}</td>
                </tr>
                @endforeach
            </tbody>
            <tfoot>
                <tr style="background-color: #e9ecef; font-weight: bold;">
                    <td colspan="3" class="text-center">TOTAL</td>
                    <td class="text-center">{{ number_format($records->sum('jumlah'), 0, ',', '.') }}</td>
                    <td class="text-right">Rp {{ number_format($records->sum('total_subtotal'), 0, ',', '.') }}</td>
                </tr>
            </tfoot>
        </table>
    @else
        <div class="no-data">
            <p>Tidak ada data penjualan untuk periode yang dipilih.</p>
        </div>
    @endif

    <div class="footer">
        Dicetak pada: {{ \Carbon\Carbon::now()->locale('id')->translatedFormat('j F Y H:i:s') }}
    </div>
</body>
</html>
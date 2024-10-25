import 'package:flutter/material.dart';

void main() {
  runApp(TaxiApp());
}

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Pembayaran Taxi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaxiCalculator(),
    );
  }
}

class TaxiCalculator extends StatefulWidget {
  @override
  _TaxiCalculatorState createState() => _TaxiCalculatorState();
}

class _TaxiCalculatorState extends State<TaxiCalculator> {
  final TextEditingController _kodeTransaksiController = TextEditingController();
  final TextEditingController _kodePenumpangController = TextEditingController();
  final TextEditingController _namaPenumpangController = TextEditingController();
  final TextEditingController _jenisPenumpangController = TextEditingController();
  final TextEditingController _platNomorController = TextEditingController();
  final TextEditingController _supirController = TextEditingController();
  final TextEditingController _biayaAwalController = TextEditingController();
  final TextEditingController _biayaPerKilometerController = TextEditingController();
  final TextEditingController _jumlahKilometerController = TextEditingController();
  
  double _totalBayar = 0.0;
  String _outputDetails = '';

  void _calculateTotalBayar() {
    double biayaAwal = double.tryParse(_biayaAwalController.text) ?? 0;
    double biayaPerKilometer = double.tryParse(_biayaPerKilometerController.text) ?? 0;
    double jumlahKilometer = double.tryParse(_jumlahKilometerController.text) ?? 0;
    String jenisPenumpang = _jenisPenumpangController.text;
    
    double gratisKm = 0;

    if (jenisPenumpang.toUpperCase() == "VIP") {
      gratisKm = 5;
    } else if (jenisPenumpang.toUpperCase() == "GOLD") {
      gratisKm = 2;
    }

    double biayaKm = (jumlahKilometer - gratisKm).clamp(0, double.infinity);
    _totalBayar = biayaAwal + (biayaPerKilometer * biayaKm);

    // Prepare output details
    _outputDetails = '''
    Kode Transaksi: ${_kodeTransaksiController.text}
    Kode Penumpang: ${_kodePenumpangController.text}
    Nama Penumpang: ${_namaPenumpangController.text}
    Jenis Penumpang: $jenisPenumpang
    Plat Nomor: ${_platNomorController.text}
    Supir: ${_supirController.text}
    Biaya Awal: Rp${biayaAwal.toStringAsFixed(2)}
    Biaya Per Kilometer: Rp${biayaPerKilometer.toStringAsFixed(2)}
    Jumlah Kilometer: $jumlahKilometer km
    Gratis Kilometer: $gratisKm km
    Kilometer yang dikenakan Biaya: $biayaKm km
    Total Bayar: Rp${_totalBayar.toStringAsFixed(2)}
    ''';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Pembayaran Taxi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _kodeTransaksiController,
                decoration: InputDecoration(labelText: 'Kode Transaksi'),
              ),
              TextField(
                controller: _kodePenumpangController,
                decoration: InputDecoration(labelText: 'Kode Penumpang'),
              ),
              TextField(
                controller: _namaPenumpangController,
                decoration: InputDecoration(labelText: 'Nama Penumpang'),
              ),
              TextField(
                controller: _jenisPenumpangController,
                decoration: InputDecoration(labelText: 'Jenis Penumpang (VIP/GOLD)'),
              ),
              TextField(
                controller: _platNomorController,
                decoration: InputDecoration(labelText: 'Plat Nomor'),
              ),
              TextField(
                controller: _supirController,
                decoration: InputDecoration(labelText: 'Supir'),
              ),
              TextField(
                controller: _biayaAwalController,
                decoration: InputDecoration(labelText: 'Biaya Awal'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _biayaPerKilometerController,
                decoration: InputDecoration(labelText: 'Biaya Per Kilometer'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _jumlahKilometerController,
                decoration: InputDecoration(labelText: 'Jumlah Kilometer'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateTotalBayar,
                child: Text('Hitung Total'),
              ),
              SizedBox(height: 20),
              if (_outputDetails.isNotEmpty) 
                Text(
                  _outputDetails,
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
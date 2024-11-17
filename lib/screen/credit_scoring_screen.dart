import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/credit_scoring_service.dart'; // Import service yang sudah dibuat

class CreditScoreScreen extends StatefulWidget {
  @override
  _CreditScoreScreenState createState() => _CreditScoreScreenState();
}

class _CreditScoreScreenState extends State<CreditScoreScreen> {
  String _skor = '';
  String _status = '';
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController(); // Menambahkan controller untuk TextField

  // Fungsi untuk mengambil data skor kredit
  Future<void> _getCreditScore(int pengajuanId) async {
    setState(() {
      _isLoading = true;
    });

    final result = await CreditScoringService().calculateCreditScore(pengajuanId);

    setState(() {
      _isLoading = false;
      if (result.containsKey('message')) {
        // Menampilkan pesan error jika ada
        _skor = result['message'];
        _status = '';
      } else {
        // Menampilkan hasil skor dan status
        _skor = result['skor'].toString();
        _status = result['status'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Scoring'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller, // Menggunakan controller untuk mengambil input
              decoration: InputDecoration(labelText: 'ID Pengajuan'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            // Menambahkan tombol untuk menghitung skor kredit
            ElevatedButton(
              onPressed: () {
                // Pastikan ID pengajuan tidak kosong
                if (_controller.text.isNotEmpty) {
                  int pengajuanId = int.parse(_controller.text);
                  _getCreditScore(pengajuanId);
                }
              },
              child: Text('Hitung Skor Kredit'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Text('Skor: $_skor'),
                      Text('Status: $_status'),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

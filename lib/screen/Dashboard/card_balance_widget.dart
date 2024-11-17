import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/anggota_services.dart';

class CardBalanceWidget extends StatefulWidget {
  final int initialCustomerCount;

  const CardBalanceWidget({Key? key, required this.initialCustomerCount}) : super(key: key);

  @override
  _CardBalanceWidgetState createState() => _CardBalanceWidgetState();
}

class _CardBalanceWidgetState extends State<CardBalanceWidget> {
  int _customerCount = 0;
  final AnggotaService _anggotaService = AnggotaService();

  @override
  void initState() {
    super.initState();
    _getCustomerCount();
  }

  Future<void> _getCustomerCount() async {
    try {
      var anggota = await _anggotaService.getData();
      if (anggota.isNotEmpty) {
        setState(() {
          _customerCount = anggota.length; // Update jumlah anggota dari data API
          print('Jumlah anggota yang diterima: $_customerCount');
        });
      } else {
        print('Tidak ada anggota yang ditemukan.');
      }
    } catch (e) {
      print('Error fetching data: $e'); // Tambahkan log error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customers',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '$_customerCount', // Tampilkan jumlah customers secara dinamis
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '', // Tambahkan teks jika diperlukan
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                '', // Tambahkan teks jika diperlukan
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Valid: 28/11/21',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}

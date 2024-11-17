import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/anggota_screen.dart';
import 'package:flutter_application_1/screen/pengajuan_screen.dart';
import 'package:flutter_application_1/screen/credit_scoring_screen.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Menentukan jumlah tombol per baris berdasarkan lebar layar
        int buttonCountPerRow = constraints.maxWidth > 600 ? 4 : 2;

        return GridView.count(
          crossAxisCount: buttonCountPerRow,
          shrinkWrap: true,
          childAspectRatio: 1.0,
          children: [
            // Tombol Master Anggota
            _buildActionButton(
              Icons.receipt_long,
              'Master Anggota',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnggotaScreen()),
                );
              },
            ),
            // Tombol Master Pengajuan
            _buildActionButton(
              Icons.money,
              'Master Pengajuan',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PengajuanScreen()),
                );
              },
            ),
            // Tombol Bill
            _buildActionButton(Icons.receipt, 'Bill', () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context)=> CreditScoreScreen())
              );
            }),
            // Tombol More
            _buildActionButton(Icons.more_horiz, 'More', () {
              // Aksi untuk tombol More
            }),
          ],
        );
      },
    );
  }

  Widget _buildActionButton(IconData icon, String title, VoidCallback onTap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black),
          ),
        ),
        SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}

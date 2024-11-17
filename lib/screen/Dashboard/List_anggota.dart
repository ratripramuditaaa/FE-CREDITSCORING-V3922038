import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/anggota_services.dart';
import 'package:flutter_application_1/Model/anggota.dart';
import 'package:flutter_application_1/screen/anggota_screen.dart';
class ListAnggota extends StatefulWidget {
  const ListAnggota({super.key});

  @override
  State<ListAnggota> createState() => _ListAnggotaState();
}

class _ListAnggotaState extends State<ListAnggota> {
  late Future<List<Anggota>> futureAnggota;

  @override
  void initState() {
    super.initState();
    futureAnggota = AnggotaService().getData(); // Memanggil fungsi untuk mengambil data
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nasabah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                // Navigasi ke halaman anggota screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnggotaScreen()),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        FutureBuilder<List<Anggota>>(
          future: futureAnggota,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Menampilkan indikator loading
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Menampilkan pesan error
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available')); // Menampilkan pesan jika tidak ada data
            }

            // Jika data berhasil diambil
            List<Anggota> anggotaList = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Mencegah scroll saat di dalam Column
              itemCount: anggotaList.length,
              itemBuilder: (context, index) {
                Anggota anggota = anggotaList[index];
                return _buildAnggotaItem(anggota);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnggotaItem(Anggota anggota) {
    return Row(
      children: [
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(anggota.nama, style: TextStyle(fontSize: 16)), // Pastikan nama field ini sesuai
            Text(anggota.nik, style: TextStyle(fontSize: 16, color: Colors.black54)), // Sesuaikan dengan model
          ],
        ),
        Spacer(),
        Icon(Icons.more_horiz),
      ],
    );
  }
}
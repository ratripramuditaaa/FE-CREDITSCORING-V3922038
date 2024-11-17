import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/anggota.dart';
import 'package:flutter_application_1/screen/Add_anggota.dart';
import 'package:flutter_application_1/services/anggota_services.dart';
import 'package:flutter_application_1/utils/global.color.dart';

class AnggotaScreen extends StatefulWidget {
  const AnggotaScreen({super.key});

  @override
  State<AnggotaScreen> createState() => _AnggotaScreenState();
}

class _AnggotaScreenState extends State<AnggotaScreen> {
  List<Anggota> listAnggota = [];
  AnggotaService anggotaService = AnggotaService();
  bool isLoading = true; // State untuk menampilkan loading

  // Fungsi untuk mengambil data anggota
  Future<void> getData() async {
    try {
      List<Anggota> data = await anggotaService.getData();
      setState(() {
        listAnggota = data; // Update list anggota
        isLoading = false; // Set loading ke false setelah data diambil
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Pastikan loading selesai meskipun terjadi error
      });
    }
  }

  // Fungsi untuk menghapus anggota
  Future<void> deleteData(int id) async {
    final success = await anggotaService.deleteData(id);
    if (success) {
      setState(() {
        listAnggota.removeWhere((anggota) => anggota.id == id); // Hapus anggota dari list
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus anggota')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData(); // Memanggil data saat initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text(
          'Master Anggota',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          isLoading // Menampilkan loading jika data belum ada
              ? Center(child: CircularProgressIndicator())
              : listAnggota.isEmpty
                  ? Center(child: Text('Tidak ada data anggota'))
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final anggota = listAnggota[index];
                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              anggota.nama,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NIK: ${anggota.nik}'),
                                Text('Tanggal Lahir: ${anggota.tgl_lahir}'),
                                Text('Alamat: ${anggota.alamat}'),
                                Text('Pekerjaan: ${anggota.pekerjaan}'),
                                Text('No telepon: ${anggota.no_tlp}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddAnggota(
                                          isUpdate: true,
                                          anggota: anggota,
                                        ),
                                      ),
                                    ).then((value) {
                                      getData(); // Refresh data saat kembali dari halaman edit anggota
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Hapus Anggota'),
                                        content: Text(
                                            'Apakah Anda yakin ingin menghapus anggota ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Tutup dialog
                                            },
                                            child: Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteData(anggota.id); // Panggil fungsi delete
                                              Navigator.of(context).pop(); // Tutup dialog
                                            },
                                            child: Text('Hapus'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: listAnggota.length,
                    ),
          // Tambahkan FloatingActionButton di posisi bawah kanan layar
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: GlobalColors.mainColor, // Sesuaikan warna dengan AppBar
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAnggota()), // Halaman tambah anggota
                ).then((value) {
                  getData(); // Refresh data saat kembali dari halaman tambah anggota
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/pengajuan.dart';
import 'package:flutter_application_1/services/pengajuan_services.dart';
import 'package:flutter_application_1/utils/global.color.dart';
import 'package:flutter_application_1/Model/anggota.dart';
import 'package:flutter_application_1/services/anggota_services.dart'; // Pastikan Anda memiliki service untuk anggota
import 'package:flutter_application_1/screen/Add_pengajuan.dart';

class PengajuanScreen extends StatefulWidget {
  const PengajuanScreen({super.key});

  @override
  State<PengajuanScreen> createState() => _PengajuanScreenState();
}

class _PengajuanScreenState extends State<PengajuanScreen> {
  List<Pengajuan> listPengajuan = [];
  List<Anggota> _anggotaList = []; // Daftar anggota
  PengajuanService pengajuanService = PengajuanService();
  AnggotaService anggotaService = AnggotaService(); // Inisialisasi service untuk anggota
  bool isLoading = true;

  // Fungsi untuk mengambil data pengajuan
  Future<void> getPengajuanData() async {
  try {
    List<dynamic> data = await pengajuanService.getPengajuan();
    setState(() {
      listPengajuan = data.map((json) {
        if (json == null) {
          return null; // Pastikan untuk menghindari null
        }
        return Pengajuan.fromJson(json);
      }).where((pengajuan) => pengajuan != null).cast<Pengajuan>().toList(); // Filter null
    });
  } catch (e) {
    print('Error fetching pengajuan data: $e');
  }
}
  // Fungsi untuk mengambil data anggota
  Future<void> getAnggotaData() async {
  try {
    List<dynamic> data = await pengajuanService.getAnggota();
    setState(() {
      _anggotaList = data.map((json) => Anggota.fromJson(json)).toList(); // Pastikan Anggota.fromJson() ada
      isLoading = false; 
    });
  } catch (e) {
    print('Error fetching anggota data: $e'); // Debugging
    setState(() {
      isLoading = false; 
    });
  }
}


  // Fungsi untuk menghapus pengajuan
  Future<void> deleteData(int id) async {
    final success = await pengajuanService.deletePengajuan(id);
    if (success) {
      setState(() {
        listPengajuan.removeWhere((pengajuan) => pengajuan.id == id);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus pengajuan')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getPengajuanData(); // Memanggil data pengajuan
    getAnggotaData(); // Memanggil data anggota
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text(
          'Master Pengajuan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : listPengajuan.isEmpty
                  ? Center(child: Text('Tidak ada data pengajuan'))
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final pengajuan = listPengajuan[index];
                        String namaAnggota = 'Anggota tidak ditemukan';

                        // Temukan nama anggota dari _anggotaList
                        for (var anggota in _anggotaList) {
                          if (anggota.id == pengajuan.anggotaId) {
                            namaAnggota = anggota.nama;
                            break; // Keluar dari loop setelah menemukan anggota
                          }
                        }

                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              '$namaAnggota',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                           subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Penghasilan: ${pengajuan.penghasilan}'),
    Text('NPWP: ${pengajuan.npwp}'),
    Text('Agunan: ${pengajuan.agunan}'),
    Text('Jenis Kredit: ${pengajuan.jenis_kredit}'),  // Tambahkan ini
    Text('Jumlah Hutang: ${pengajuan.jumlah_hutang}'), // Tambahkan ini
    Text('Tanggal Pengajuan: ${pengajuan.tanggal_pengajuan}'),
    Text('Tanggal Mulai: ${pengajuan.tanggal_mulai}'), // Tambahkan ini
    Text('Tanggal Selesai: ${pengajuan.tanggal_selesai}'), // Tambahkan ini
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
                                        builder: (context) => AddPengajuan(
                                          isUpdate: true,
                                          pengajuan: pengajuan,
                                        ),
                                      ),
                                    ).then((value) {
                                      getPengajuanData(); // Refresh data setelah kembali dari halaman edit
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Hapus Pengajuan'),
                                        content: Text('Apakah Anda yakin ingin menghapus pengajuan ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Tutup dialog
                                            },
                                            child: Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteData(pengajuan.id!); // Gunakan null check dengan tanda seru (!) 
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
                      itemCount: listPengajuan.length,
                    ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: GlobalColors.mainColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPengajuan()), // Halaman tambah pengajuan
                ).then((value) {
                  getPengajuanData(); // Refresh data saat kembali dari halaman tambah
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

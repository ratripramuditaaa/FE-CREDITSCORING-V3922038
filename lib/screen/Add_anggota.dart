import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/widgets/text.form.global.dart';
import 'package:flutter_application_1/services/anggota_services.dart';
import 'package:flutter_application_1/screen/anggota_screen.dart';
import 'package:flutter_application_1/Model/anggota.dart';
import 'package:flutter_application_1/screen/widgets/button.global.dart';

class AddAnggota extends StatefulWidget {
  final Anggota? anggota;
  final bool isUpdate;

  const AddAnggota({super.key, this.anggota, this.isUpdate = false});

  @override
  State<AddAnggota> createState() => _AddAnggotaState();
}

class _AddAnggotaState extends State<AddAnggota> {
  AnggotaService anggotaService = AnggotaService();
  
  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final tgl_lahirController = TextEditingController();
  final alamatController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final no_tlpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate && widget.anggota != null) {
      namaController.text = widget.anggota!.nama;
      nikController.text = widget.anggota!.nik;
      tgl_lahirController.text = widget.anggota!.tgl_lahir;
      alamatController.text = widget.anggota!.alamat;
      pekerjaanController.text = widget.anggota!.pekerjaan;
      no_tlpController.text = widget.anggota!.no_tlp;
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    nikController.dispose();
    tgl_lahirController.dispose();
    alamatController.dispose();
    pekerjaanController.dispose();
    no_tlpController.dispose();
    super.dispose();
  }

  bool validateInput() {
    if (namaController.text.isEmpty ||
        nikController.text.isEmpty ||
        tgl_lahirController.text.isEmpty ||
        alamatController.text.isEmpty ||
        pekerjaanController.text.isEmpty ||
        no_tlpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return false;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(nikController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('NIK harus berupa angka')),
      );
      return false;
    }
    return true;
  }

  void saveData() async {
    if (validateInput()) {
      try {
        bool response;
        if (widget.isUpdate) {
          String id = widget.anggota!.id.toString();
          response = await anggotaService.updateData(
            id: id,
            nama: namaController.text,
            nik: nikController.text,
            tgl_lahir: tgl_lahirController.text,
            alamat: alamatController.text,
            pekerjaan: pekerjaanController.text,
            no_tlp: no_tlpController.text,
          );
        } else {
          response = await anggotaService.postData(
            nama: namaController.text,
            nik: nikController.text,
            tgl_lahir: tgl_lahirController.text,
            alamat: alamatController.text,
            pekerjaan: pekerjaanController.text,
            no_tlp: no_tlpController.text,
          );
        }
        if (response) {
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.isUpdate ? 'Gagal memperbarui anggota' : 'Gagal menambahkan anggota')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Anggota'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double padding = screenWidth > 600 ? 32.0 : 16.0;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  TextFormGlobal(
                    controller: namaController,
                    text: 'Nama',
                    icon: Icons.person,
                    textInputType: TextInputType.name,
                    obscure: false,
                  ),
                  SizedBox(height: 20),

                  TextFormGlobal(
                    controller: nikController,
                    text: 'NIK',
                    icon: Icons.badge,
                    textInputType: TextInputType.number,
                    obscure: false,
                  ),
                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        tgl_lahirController.text = pickedDate.toLocal().toString().split(' ')[0];
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormGlobal(
                        controller: tgl_lahirController,
                        text: 'Tanggal Lahir',
                        icon: Icons.calendar_today,
                        textInputType: TextInputType.datetime,
                        obscure: false,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextFormGlobal(
                    controller: alamatController,
                    text: 'Alamat',
                    icon: Icons.home,
                    textInputType: TextInputType.streetAddress,
                    obscure: false,
                  ),
                  SizedBox(height: 20),

                  TextFormGlobal(
                    controller: pekerjaanController,
                    text: 'Pekerjaan',
                    icon: Icons.work,
                    textInputType: TextInputType.text,
                    obscure: false,
                  ),
                  SizedBox(height: 20),

                  TextFormGlobal(
                    controller: no_tlpController,
                    text: 'Nomor Telepon',
                    icon: Icons.security,
                    textInputType: TextInputType.text,
                    obscure: false,
                  ),
                  SizedBox(height: 20),

                  // Ganti dengan ButtonGlobal
                  ButtonGlobal(
                    text: widget.isUpdate ? 'Update' : 'Submit',
                    onTap: saveData, // Menggunakan onTap untuk aksi ketika tombol ditekan
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

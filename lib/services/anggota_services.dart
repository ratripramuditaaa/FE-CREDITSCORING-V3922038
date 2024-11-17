import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Model/anggota.dart';

class AnggotaService {
  final String _baseUrl = 'http://192.168.200.37:8000/api/anggota';

  // Fetch data dari API
  Future<List<Anggota>> getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);
        List<Anggota> anggota = responseBody.map((json) => Anggota.fromJson(json)).toList();
        return anggota;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  // Menambahkan data baru ke API
  Future<bool> postData({
    required String nama,
    required String nik,
    required String tgl_lahir,
    required String alamat,
    required String pekerjaan,
    required String no_tlp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nama,
          'nik': nik,
          'tgl_lahir': tgl_lahir,
          'alamat': alamat,
          'pekerjaan': pekerjaan,
          'no_tlp': no_tlp,
        }),
      );

      if (response.statusCode == 201) {
        print('Data berhasil ditambahkan');
        return true;
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error posting data: $e');
      return false;
    }
  }

  // Mengupdate data berdasarkan ID
  Future<bool> updateData({
    required String id,
    required String nama,
    required String nik,
    required String tgl_lahir,
    required String alamat,
    required String pekerjaan,
    required String no_tlp,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nama,
          'nik': nik,
          'tgl_lahir': tgl_lahir,
          'alamat': alamat,
          'pekerjaan': pekerjaan,
          'no_tlp': no_tlp,
        }),
      );

      if (response.statusCode == 200) {
        print('Data berhasil diperbarui');
        return true;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating data: $e');
      return false;
    }
  }

  // Menghapus data berdasarkan ID
  Future<bool> deleteData(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Data berhasil dihapus');
        return true;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting data: $e');
      return false;
    }
  }
}

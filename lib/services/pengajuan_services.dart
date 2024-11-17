import 'dart:convert';
import 'package:http/http.dart' as http;

class PengajuanService {
  final String baseUrl = 'http://192.168.200.37:8000/api';

  Future<List<dynamic>> getAnggota() async {
  final response = await http.get(Uri.parse('$baseUrl/anggota'));
  print('Response status: ${response.statusCode}'); // Debugging
  print('Response body: ${response.body}'); // Debugging
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load anggota: ${response.reasonPhrase}');
  }
}
  Future<List<dynamic>> getPengajuan() async {
    final response = await http.get(Uri.parse('$baseUrl/pengajuan'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pengajuan: ${response.reasonPhrase}');
    }
  }

  Future<void> submitPengajuan(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pengajuan'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit pengajuan: ${response.reasonPhrase}');
    }
  }

  Future<void> updatePengajuan(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pengajuan/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pengajuan: ${response.reasonPhrase}');
    }
  }

  Future<bool> deletePengajuan(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pengajuan/$id'));

    if (response.statusCode == 200) {
      return true; // Berhasil dihapus
    } else {
      throw Exception('Failed to delete pengajuan: ${response.reasonPhrase}');
    }
  }
}

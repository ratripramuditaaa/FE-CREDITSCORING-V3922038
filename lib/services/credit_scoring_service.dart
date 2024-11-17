import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreditScoringService {
  // URL API Laravel
  static const String apiUrl = 'http://192.168.200.37:8000/api/calculate-credit-score';

  // Fungsi untuk mendapatkan token dari SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Fungsi untuk menghitung skor kredit
  Future<Map<String, dynamic>> calculateCreditScore(int pengajuanId) async {
    try {
      // Dapatkan token autentikasi
      String? token = await getToken();

      // Periksa apakah token tersedia
      if (token == null) {
        return {'message': 'Token tidak ditemukan'};
      }

      // Buat URL lengkap dengan menambahkan ID pengajuan
      final url = Uri.parse('$apiUrl/$pengajuanId');

      // Lakukan permintaan HTTP POST dengan token dalam header
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Log response status code dan body untuk debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Jika sukses, kembalikan response JSON
        return jsonDecode(response.body);
      } else {
        // Jika ada error, kembalikan pesan error
        return {'message': 'Error: ${response.statusCode}'};
      }
    } catch (e) {
      // Log error di konsol
      print('Terjadi kesalahan: $e');
      return {'message': 'Terjadi kesalahan: $e'};
    }
  }
}

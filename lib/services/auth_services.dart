import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/services/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  // Fungsi untuk menyimpan token
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Fungsi untuk mengambil token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> register(
    String name, String email, String no_telepon, String posisi, String password) async {
    
    Map data = {
      "name": name,
      "email": email,
      "no_telepon": no_telepon,
      "posisi": posisi,
      "password": password,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseURL + '/auth/register');

    print('Request Body: $body'); // Log request body

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response Status: ${response.statusCode}'); // Log status code
    print(response.body); // Log response body

    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + '/auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
}

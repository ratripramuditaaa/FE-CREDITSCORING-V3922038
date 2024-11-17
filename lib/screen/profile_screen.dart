import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Ganti dengan import dari file login screen Anda

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    if (token == null) {
      print('Token is null, user is not logged in.');
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://192.168.200.26:8000/api/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = json.decode(response.body)['profile'];
          isLoading = false;
        });
      } else {
        print('Failed to fetch profile: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _editProfilePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController(text: userData?['name']);
        final TextEditingController posisiController = TextEditingController(text: userData?['posisi']);
        final TextEditingController teleponController = TextEditingController(text: userData?['no_telepon']);

        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: posisiController,
                decoration: const InputDecoration(labelText: 'Posisi'),
              ),
              TextField(
                controller: teleponController,
                decoration: const InputDecoration(labelText: 'No Telepon'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateProfile(
                  nameController.text,
                  posisiController.text,
                  teleponController.text,
                );
                Navigator.of(context).pop();
                _fetchUserData(); // Refresh data setelah update
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateProfile(String name, String posisi, String noTelepon) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    if (token == null) {
      print('Token is null, user is not logged in.');
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('http://192.168.200.26:8000/api/profile/update'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'name': name,
          'posisi': posisi,
          'no_telepon': noTelepon,
          // Password hanya dikirim jika tidak kosong
          // Jika Anda ingin menambahkan password, tambahkan field untuk password di sini
        },
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
      } else {
        print('Failed to update profile: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token'); // Hapus token
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen())); // Ganti dengan route ke halaman login Anda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/funny.jpeg'),
                        ),
                      ),
                      const SizedBox(height: 20),

                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          userData?['name'] ?? 'Nama tidak tersedia',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: _editProfilePopup,
                        ),
                      ),
                      const Divider(),

                      ListTile(
                        leading: const Icon(Icons.work),
                        title: Text(
                          userData?['posisi'] ?? 'Posisi tidak tersedia',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(),

                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(
                          userData?['no_telepon'] ?? 'No telepon tidak tersedia',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: Text('User not found')),
    );
  }
}

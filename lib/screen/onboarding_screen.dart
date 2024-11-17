import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.color.dart';
import 'package:flutter_application_1/screen/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bagian gambar
            Expanded(
              child: Image.asset(
                  'assets/images/logo1.png',
                  fit: BoxFit.contain,
                ),
            ),
            SizedBox(height: 20),
            // Teks deskripsi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'Welcome to ScoreXpert',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Evaluasi Kredit Cepat, Keputusan Tepat ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Tombol Continue
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Warna latar belakang tombol
                  foregroundColor: GlobalColors.textColor, // Warna teks tombol
                  minimumSize: Size(double.infinity, 50), // Lebar penuh tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text('Get started'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: GlobalColors.mainColor, // Ganti sesuai dengan kebutuhan
    );
  }
}
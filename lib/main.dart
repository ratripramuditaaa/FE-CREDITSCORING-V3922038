import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth UI',
      theme: ThemeData(
        // Set default font for the entire app to Merriweather
        textTheme: GoogleFonts.merriweatherTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

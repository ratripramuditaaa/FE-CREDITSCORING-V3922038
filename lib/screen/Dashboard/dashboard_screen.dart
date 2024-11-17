import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Dashboard/card_balance_widget.dart';
import 'package:flutter_application_1/screen/Dashboard/action_button_widget.dart';
import 'package:flutter_application_1/screen/Dashboard/list_anggota.dart';
import 'package:flutter_application_1/screen/profile_screen.dart'; // Sesuaikan dengan lokasi ProfileScreen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // Menyimpan indeks item yang dipilih

  // Fungsi untuk menangani tap pada item BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) { // Tab ke-3 (Profil)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Ratri Pramudita',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/funny.jpeg'),
            radius: 50,
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CardBalanceWidget(initialCustomerCount: 2),
            SizedBox(height: 30),
            const ActionButtonsWidget(),
            SizedBox(height: 50),
            const ListAnggota(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // Fungsi yang dipanggil ketika item diklik
      ),
    );
  }
}

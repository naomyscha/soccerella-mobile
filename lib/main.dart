import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:soccerella/screens/menu.dart';
import 'package:soccerella/screens/login.dart';

// Definisi warna kustom untuk tema Soccerella (Pink Fuchsia dari screenshot)
const Color primarySoccerella = Color.fromARGB(255, 236, 64, 122); 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Soccerella',
        theme: ThemeData(
          useMaterial3: true,
          // Menggunakan warna kustom untuk ColorScheme
          colorScheme: ColorScheme.fromSeed(
            seedColor: primarySoccerella, 
            primary: primarySoccerella, // Warna Pink Cerah untuk Aksen Utama
            secondary: Colors.pinkAccent.shade100, // Aksen lebih lembut
            background: const Color.fromARGB(255, 255, 248, 250), // Background (Cream/Pink Sangat Muda)
            surface: Colors.white, // Surface untuk Card dan Dialog
          ),
          
          // --- Custom Theme Component ---
          
          // AppBar (Latar belakang putih bersih, teks hitam)
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1, // Sedikit bayangan
          ),
          
          // Card Theme (Sesuai design Soccerella: Rounded dan putih)
          cardTheme: CardThemeData( // Pastikan menggunakan CardThemeData, BUKAN CardTheme
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
          ),
          
          // Tombol Elevated (Warna Pink Cerah, Teks Putih)
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primarySoccerella, 
              foregroundColor: Colors.white, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Halaman awal saat aplikasi dibuka
        home: const LoginPage(),
      ),
    );
  }
}
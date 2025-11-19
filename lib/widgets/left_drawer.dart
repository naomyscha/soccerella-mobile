import 'package:flutter/material.dart';
import 'package:soccerella/screens/menu.dart';
import 'package:soccerella/screens/product_form.dart';
import 'package:soccerella/screens/shop_item_list.dart'; // Wajib: Import halaman daftar produk
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:soccerella/screens/login.dart'; // Asumsi LoginPage di sini

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  // 🎨 Definisikan warna tema Soccerella (Pink/Magenta)
  static const Color soccerellaPrimary = Color(0xFFE91E63);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              // 🎨 Terapkan warna utama Soccerella (Pink/Magenta)
              color: soccerellaPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Soccerella ⚽️',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kelola produk dan berita bola kamu!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),

          // ===== 1. Halaman Utama (Menu) =====
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),

          // ===== 2. Daftar Semua Produk (Fase 3 & 4) =====
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Daftar Produk'),
            onTap: () {
              // Navigasi ke halaman daftar produk (Filter OFF secara default)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ShopItemListPage(initialFilterByUser: false),
                ),
              );
            },
          ),

          // ===== 3. Tambah Produk (Form/Fase 5) =====
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Tambah Produk'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductFormPage(),
                ),
              );
            },
          ),

          // 🔒 LIST TILE LOGOUT
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              // ⚠️ GANTI [Your_APP_URL]
              final response = await request.logout(
                "http://localhost:8000/auth/logout/",
              ); // 🚀 KOREKSI URL EMULATOR

              if (context.mounted) {
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sampai jumpa, $uname.")),
                  );
                  // Navigasi ke halaman login setelah logout
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(response['message'])));
                }
              }
            },
          ),
          // ⚠️ PENTING: Tambahkan tombol Logout di sini nanti (Fase 5)
        ],
      ),
    );
  }
}

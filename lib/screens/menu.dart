import 'package:flutter/material.dart';
import 'package:soccerella/screens/product_form.dart';
import 'package:soccerella/widgets/left_drawer.dart';
// Wajib: Import halaman daftar produk untuk navigasi
import 'package:soccerella/screens/shop_item_list.dart'; 


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String nama = "Naomyscha Attalie Maza";
  final String npm = "2406348433";
  final String kelas = "B";
  
  // 🎨 Definisikan warna tema Soccerella di sini
  static const Color soccerellaPrimary = Color(0xFFE91E63); // Pink/Magenta Cerah
  static const Color soccerellaSecondary = Color(0xFFF06292); // Pink Lebih Muda
  static const Color soccerellaSuccess = Color(0xFF8BC34A); // Hijau untuk My Items

  final List<ItemHomepage> items = const [
    // 🎨 Ubah warna tombol agar senada dengan tema Pink/Magenta
    ItemHomepage("All Products", Icons.list, soccerellaSecondary), 
    ItemHomepage("My Products", Icons.shopping_bag, soccerellaSuccess), // Warna hijau untuk membedakan filter
    ItemHomepage("Create Product", Icons.add_circle, soccerellaPrimary), // Warna utama untuk aksi penting
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Soccerella',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // 🎨 Terapkan warna utama Soccerella
        backgroundColor: soccerellaPrimary, 
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Welcome to Soccerella!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: items.map((item) => ItemCard(item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Card sederhana untuk identitas
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      // 🎨 Terapkan warna latar belakang putih bersih untuk InfoCard
      child: Container(
        width: MediaQuery.of(context).size.width / 3.8,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(content),
          ],
        ),
      ),
    );
  }
}

// Model data untuk button
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

// Kartu tombol berwarna
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman form tambah produk
          if (item.name == "Create Product") {
            // ✅ Navigasi ke Form Tambah Produk
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          } else if (item.name == "All Products") {
            // ✅ Navigasi ke Daftar Produk (Filter OFF: Melihat semua produk)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShopItemListPage(initialFilterByUser: false),
              ),
            );
          } else if (item.name == "My Products") {
            // ✅ Navigasi ke Daftar Produk (Filter ON: Hanya melihat produk milik sendiri)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShopItemListPage(initialFilterByUser: true),
              ),
            );
          } else {
             // Logic fallback jika ada tombol baru yang belum terdefinisi
             ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("Aksi untuk ${item.name} belum didefinisikan.")),
                );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 5),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
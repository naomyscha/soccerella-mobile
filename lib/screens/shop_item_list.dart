// lib/screens/shop_item_list.dart
import 'package:flutter/material.dart';
import 'package:soccerella/models/shop_item.dart';
import 'package:soccerella/widgets/left_drawer.dart'; // Jika ada drawer
import 'package:soccerella/widgets/shop_item_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:soccerella/screens/shop_item_detail.dart'; // Import halaman detail

class ShopItemListPage extends StatefulWidget {
  final bool initialFilterByUser;
  const ShopItemListPage({super.key, this.initialFilterByUser = false});

  @override
  State<ShopItemListPage> createState() => _ShopItemListPageState();
}

class _ShopItemListPageState extends State<ShopItemListPage> {
  // 🆕 Gunakan 'late' karena akan diinisialisasi di initState
  late bool isFilteredByUser;

  @override
  void initState() {
    super.initState();
    // 🎯 KOREKSI #1: Inisialisasi state menggunakan nilai dari widget (yang dikirim dari MyHomePage)
    isFilteredByUser = widget.initialFilterByUser;
  }

  // Fungsi untuk mengambil data produk dari Django
  Future<List<ShopItem>> fetchItems(CookieRequest request) async {
    String url;

    // 🚀 KOREKSI #2: Ganti localhost:8000 menjadi localhost:8000
    if (isFilteredByUser) {
      // 🎯 Endpoint terfilter (hanya produk pengguna)
      url = 'http://localhost:8000/user-json/';
    } else {
      // 🌐 Endpoint default (semua produk)
      url = 'http://localhost:8000/json/';
    }
    // Ganti localhost:8000 jika Anda menggunakan deployment/Chrome.

    final response = await request.get(url);

    // Konversi JSON response ke list of ShopItem objects
    List<ShopItem> listItems = [];
    for (var d in response) {
      if (d != null) {
        // Menggunakan ShopItem.fromJson(d['fields']) sesuai dengan model Anda
        listItems.add(ShopItem.fromJson(d));
      }
    }
    return listItems;
  }

  // Fungsi untuk memicu perubahan filter dan re-fetch data
  void toggleFilter(bool value) {
    setState(() {
      isFilteredByUser = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk Soccerella'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,

        actions: [
          Row(
            children: [
              const Text(
                'Hanya Produk Saya',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Switch(
                value: isFilteredByUser,
                // Hanya aktif jika pengguna sudah login (request.loggedIn)
                onChanged: request.loggedIn ? toggleFilter : null,
                activeColor: theme.colorScheme.secondary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.white38,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      // drawer: const LeftDrawer(), // Aktifkan jika ada drawer navigasi
      body: FutureBuilder<List<ShopItem>>(
        future: fetchItems(request),
        builder: (context, snapshot) {
          // Masih loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Ada error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Tidak ada data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                isFilteredByUser
                    ? 'Anda belum menambahkan produk.'
                    : 'Belum ada produk di Soccerella.',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Ada data → tampilkan list
          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) => ShopItemCard(
              item: items[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShopItemDetailPage(item: items[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

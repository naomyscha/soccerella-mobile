// lib/screens/shop_item_list.dart
import 'package:flutter/material.dart';
import 'package:soccerella/models/shop_item.dart';
import 'package:soccerella/widgets/left_drawer.dart'; // Jika ada drawer
import 'package:soccerella/widgets/shop_item_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:soccerella/screens/shop_item_detail.dart'; // Import halaman detail

class ShopItemListPage extends StatefulWidget {
  const ShopItemListPage({super.key});

  @override
  State<ShopItemListPage> createState() => _ShopItemListPageState();
}

class _ShopItemListPageState extends State<ShopItemListPage> {
  
  // 🆕 State untuk mengontrol filter
  bool isFilteredByUser = false; 

  // Fungsi untuk mengambil data produk dari Django
  Future<List<ShopItem>> fetchItems(CookieRequest request) async {
    String url;
    
    if (isFilteredByUser) {
      // 🎯 Endpoint terfilter (hanya produk pengguna)
      url = 'http://localhost:8000/main/user-json/';
    } else {
      // 🌐 Endpoint default (semua produk)
      url = 'http://localhost:8000/main/json/';
    }
    // ⚠️ PENTING: GANTI localhost:8000 dengan [YOUR_APP_URL] atau 10.0.2.2:8000 jika menggunakan emulator.

    final response = await request.get(url);
    
    // Konversi JSON response ke list of ShopItem objects
    List<ShopItem> listItems = [];
    for (var d in response) {
      if (d != null) {
        // Menggunakan ShopItem.fromJson(d['fields']) sesuai dengan model Anda
        listItems.add(ShopItem.fromJson(d['fields'])); 
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
        backgroundColor: theme.colorScheme.primary, // Sesuaikan tema
        foregroundColor: Colors.white,
        
        // 🆕 Tambahkan tombol filter di actions
        actions: [
          Row(
            children: [
              const Text('Hanya Produk Saya', style: TextStyle(fontSize: 14, color: Colors.white)),
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
      body: FutureBuilder(
        // FutureBuilder akan re-run setiap kali setState (toggleFilter) dipanggil
        future: fetchItems(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isFilteredByUser 
                      ? 'Anda belum menambahkan produk.' 
                      : 'Belum ada produk di Soccerella.',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ShopItemCard(
                  item: snapshot.data![index],
                  onTap: () {
                    // ✅ Navigasi ke halaman detail (sudah benar)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopItemDetailPage(
                          item: snapshot.data![index], 
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
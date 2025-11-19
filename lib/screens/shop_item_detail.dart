// lib/screens/shop_item_detail.dart
import 'package:flutter/material.dart';
import 'package:soccerella/models/shop_item.dart'; // Sesuaikan dengan path model Anda

class ShopItemDetailPage extends StatelessWidget {
  final ShopItem item;

  const ShopItemDetailPage({super.key, required this.item});

  // Helper untuk format Rupiah
  String _formatPrice(int price) {
    // Implementasi sederhana, bisa diganti dengan package intl yang lebih baik
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        // Warna AppBar disesuaikan dengan tema utama Soccerella
        backgroundColor: theme.colorScheme.primary, 
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk (Thumbnail)
            if (item.fields.thumbnail.isNotEmpty)
              Image.network(
                // Gunakan URL proxy atau URL langsung yang sudah disesuaikan
                'http://localhost:8000/main/proxy-image/?url=${Uri.encodeComponent(item.fields.thumbnail)}',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: theme.colorScheme.background,
                  child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Produk
                  Text(
                    item.fields.name,
                    style: theme.textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Harga
                  Text(
                    _formatPrice(item.fields.price),
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.secondary, // Warna Pink Cerah
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Kategori
                  Row(
                    children: [
                      Icon(Icons.category, size: 18, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Kategori: ${item.fields.category}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Divider(height: 30),

                  // Featured Badge
                  if (item.fields.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '🌟 FEATURED ITEM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),

                  // Deskripsi Penuh
                  const Text(
                    'Deskripsi Produk:',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.fields.description,
                    style: const TextStyle(fontSize: 15.0, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),

                  // Tombol Kembali (sudah ada di AppBar, tapi bisa ditambah jika perlu)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Kembali ke Daftar Produk'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.primary,
                        side: BorderSide(color: theme.colorScheme.primary),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
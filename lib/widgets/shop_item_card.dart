// lib/widgets/shop_item_card.dart
import 'package:flutter/material.dart';
import 'package:soccerella/models/shop_item.dart'; // Ganti dengan nama package dan model Anda

class ShopItemCard extends StatelessWidget {
  final ShopItem item;
  final VoidCallback onTap;

  const ShopItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Terapkan design Soccerella: Card dengan rounded corner, dominasi pink/putih
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Card(
          // Card Theme dari main.dart sudah mengatur shape dan elevation
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    // GANTI URL INI jika menggunakan proxy atau lokal.
                    // Jika deployment, ganti localhost:8000 dengan URL deployment Anda.
                    'http://localhost:8000/main/proxy-image/?url=${Uri.encodeComponent(item.fields.thumbnail)}',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Theme.of(
                        context,
                      ).colorScheme.background, // Background pink muda
                      child: const Center(
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Nama Produk
                Text(
                  item.fields.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),

                // Harga
                Text(
                  'Rp ${item.fields.price.toStringAsFixed(0)}', // Sesuaikan format Rupiah
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary, // Warna Pink Cerah
                  ),
                ),
                const SizedBox(height: 6),

                // Kategori
                Text(
                  'Kategori: ${item.fields.category}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),

                // Description Preview
                Text(
                  item.fields.description.length > 50
                      ? '${item.fields.description.substring(0, 50)}...'
                      : item.fields.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),

                // Featured Indicator
                if (item.fields.isFeatured)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '🌟 FEATURED ITEM',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

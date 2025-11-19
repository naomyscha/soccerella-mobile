import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:soccerella/screens/menu.dart';
import 'package:soccerella/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "jersey";
  bool _isFeatured = false;

  final List<String> _categories = [
    'jersey',
    'shoes',
    'accessories',
    'ball',
    'other',
  ];

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && uri.isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final theme = Theme.of(context);

    // SESUAIKAN: localhost / 10.0.2.2 / domain deploy
    const baseUrl = "http://localhost:8000";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== TITLE =====
                  Center(
                    child: Text(
                      "Buat Produk Baru",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ===== NAME =====
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nama Produk",
                      hintText: "cth: Jersey Argentina Home",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) => setState(() => _name = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nama produk tidak boleh kosong!";
                      }
                      if (value.length < 3) {
                        return "Nama produk minimal 3 karakter";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // ===== PRICE =====
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Harga",
                      hintText: "cth: 250000",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) =>
                        setState(() => _price = int.tryParse(value) ?? 0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harga tidak boleh kosong!";
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null) {
                        return "Harga harus berupa angka!";
                      }
                      if (parsed <= 0) {
                        return "Harga harus lebih dari 0!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // ===== DESCRIPTION =====
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
                      hintText:
                          "cth: Jersey original size M, bahan adem, kondisi 9/10...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) =>
                        setState(() => _description = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                      }
                      if (value.length < 10) {
                        return "Deskripsi minimal 10 karakter!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // ===== CATEGORY =====
                  DropdownButtonFormField<String>(
                    value: _category,
                    decoration: InputDecoration(
                      labelText: "Kategori",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    items: _categories
                        .map(
                          (cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _category = value ?? 'jersey'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Kategori harus dipilih!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // ===== THUMBNAIL =====
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Thumbnail URL",
                      hintText: "cth: https://example.com/jersey.png",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) =>
                        setState(() => _thumbnail = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Thumbnail tidak boleh kosong!";
                      }
                      if (!_isValidUrl(value)) {
                        return "Masukkan URL yang valid!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  // ===== FEATURED =====
                  SwitchListTile(
                    title: const Text("Tandai produk sebagai Featured"),
                    value: _isFeatured,
                    activeColor: theme.colorScheme.secondary,
                    onChanged: (value) =>
                        setState(() => _isFeatured = value),
                  ),
                  const SizedBox(height: 16),

                  // ===== SAVE BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                            "http://localhost:8000/create-flutter/",
                            jsonEncode({
                              "name": _name,
                              "price": _price,
                              "description": _description,
                              "thumbnail": _thumbnail,
                              "category": _category,
                              "is_featured": _isFeatured,
                            }),
                          );

                          if (!mounted) return;

                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Produk berhasil dipublikasikan!"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Gagal menyimpan produk: ${response['message']}",
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Simpan Produk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

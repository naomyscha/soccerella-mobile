import 'package:flutter/material.dart';
import 'package:soccerella/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // field yang diinput user
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

  // validator sederhana untuk URL
  bool _isValidUrl(String value) {
    return Uri.tryParse(value)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== NAME =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nama Produk",
                    hintText: "cth: Jersey Argentina Home",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
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
              ),

              // ===== PRICE =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Harga",
                    hintText: "cth: 250000",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // kalau kosong jangan di-parse
                      _price = int.tryParse(value) ?? 0;
                    });
                  },
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
              ),

              // ===== DESCRIPTION =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    hintText: "cth: Jersey original size M, bahan adem...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
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
              ),

              // ===== CATEGORY (dropdown) =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: _category,
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Kategori harus dipilih!";
                    }
                    return null;
                  },
                ),
              ),

              // ===== THUMBNAIL (URL) =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Thumbnail URL",
                    hintText: "cth: https://example.com/jersey.png",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _thumbnail = value;
                    });
                  },
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
              ),

              // ===== FEATURED (switch) =====
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai produk sebagai Featured"),
                  value: _isFeatured,
                  onChanged: (value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // ===== SAVE BUTTON =====
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // kalau valid → tampilkan dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  const Text("Produk berhasil disimpan"),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama: $_name"),
                                    Text("Harga: $_price"),
                                    Text("Deskripsi: $_description"),
                                    Text("Kategori: $_category"),
                                    Text("Thumbnail: $_thumbnail"),
                                    Text("Featured: ${_isFeatured ? "Ya" : "Tidak"}"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // reset form
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _category = "jersey";
                                      _isFeatured = false;
                                      _price = 0;
                                    });
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

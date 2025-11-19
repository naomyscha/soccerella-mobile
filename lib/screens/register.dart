import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:soccerella/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk form validation
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late Color primaryColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mengambil warna Pink/Fuchsia dari tema global
    primaryColor = Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun Baru'),
        elevation: 1, // Diwarisi dari tema
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0), // Padding disesuaikan
          child: Card(
            // Card theme (rounded, putih) diwarisi dari main.dart
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                // Menggunakan Form untuk validasi
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Buat Akun Soccerella',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Masukkan detail akun Anda',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 30.0),

                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Masukkan username',
                        prefixIcon: Icon(Icons.person_add, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0), // Spasi disesuaikan
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan password',
                        prefixIcon: Icon(Icons.key, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0), // Spasi disesuaikan
                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                        hintText: 'Ulangi password',
                        prefixIcon: Icon(Icons.verified, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon konfirmasi password.';
                        }
                        if (value != _passwordController.text) {
                          return 'Konfirmasi password tidak cocok!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30.0),

                    // Tombol Register
                    ElevatedButton(
                      onPressed: () async {
                        // Hanya proses jika form valid
                        if (_formKey.currentState!.validate()) {
                          String username = _usernameController.text;
                          String password1 = _passwordController.text;
                          String password2 = _confirmPasswordController.text;

                          // POST ke Django (URL localhost dipertahankan)
                          final response = await request.postJson(
                            "http://localhost:8000/auth/register/",
                            jsonEncode({
                              "username": username,
                              "password1": password1,
                              "password2": password2,
                            }),
                          );

                          if (context.mounted) {
                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Akun ${response['username']} berhasil dibuat! Silakan Login.',
                                  ),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            } else {
                              // Menampilkan pesan error dari Django
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Registrasi Gagal: ${response['message']}',
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      // Style button diwarisi dari elevatedButtonTheme di main.dart (Pink/Fuchsia)
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        'DAFTAR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String nama = "Naomyscha Attalie Maza";
  final String npm = "2406348433";
  final String kelas = "B";

  final List<ItemHomepage> items = const [
    ItemHomepage("All Products", Icons.list, Colors.blue),
    ItemHomepage("My Products", Icons.shopping_bag, Colors.green),
    ItemHomepage("Create Product", Icons.add_circle, Colors.red),
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
        backgroundColor: Colors.blue,
      ),
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
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}")),
            );
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

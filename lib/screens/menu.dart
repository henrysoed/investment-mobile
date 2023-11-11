import 'package:flutter/material.dart';
import 'package:investment_inventory/widgets/left_drawer.dart';
import 'package:investment_inventory/screens/shoplist_form.dart';
import 'package:investment_inventory/widgets/shop_card.dart';
import 'package:investment_inventory/screens/list_item.dart';
import 'dart:math' as math;

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
      final List<ShopItem> items = [
      ShopItem("Lihat Item", Icons.checklist, Colors.blue),
      ShopItem("Tambah Item", Icons.note_add_outlined, Colors.green),
      ShopItem("Logout", Icons.logout, Colors.red),
    ];

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Inventory',),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Investment Inventory', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
    }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
}

class Item {
  final String name;
  final IconData icon;
  final Color color;

  Item(this.name, this.icon, this.color);
}

class ItemDisplay {
  final IconData icon;

  ItemDisplay(this.icon);
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Pindah halaman
          if (item.name == "Tambah Item") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const InventoryFormPage()));
          } else if (item.name == "Lihat Item") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListItemPage()));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemDisplayCard extends StatelessWidget {
  final ItemDisplay itemDisplay;

  const ItemDisplayCard(this.itemDisplay, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: //itemDisplay.color,
          const Color(0x068FFF),
      child: Center(
        child: Icon(
          itemDisplay.icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class InventoryItem {
  final String name;
  final int price;
  final int amount;
  final String description;

  InventoryItem(this.name, this.amount, this.price, this.description);
}
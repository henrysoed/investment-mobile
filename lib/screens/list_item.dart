import 'package:flutter/material.dart';
import 'package:investment_inventory/screens/menu.dart';
import 'package:investment_inventory/widgets/left_drawer.dart';
import 'dart:math' as math;

class ListItemPage extends StatefulWidget {
  const ListItemPage({super.key});

  @override
  State<ListItemPage> createState() => WiListItemPage();
}

class WiListItemPage extends State<ListItemPage> {
  static List<InventoryItem> database = <InventoryItem>[
    InventoryItem("Ashmore Balanced", 250, 1500000, "Reksadana Campuran dengan risiko 50%"),
    InventoryItem("Aurora Equity", 150, 1800000, "Reksadana Saham dengan risiko 75%"),
    InventoryItem("Millenium Equity", 250, 1750000, "Reksadana Saham dengan resiko 75%"),
    InventoryItem("Sucorinvest Premium Fund", 450, 2500000, "Reksadana Campuran dengan resiko 50%"),
    InventoryItem("BNP Utama", 350, 1000000, "Reksadana Pendapatan Tetap dengan resiko 33%"),
    InventoryItem("Foster Fixed Income", 450, 1200000, "Reksadana Pendapatan Tetap dengan resiko 33%"),
    InventoryItem("Danareksa Likuid", 500, 1000000, "Reksadana Pasar Uang dengan resiko 25%"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Investment Inventory',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white),
      endDrawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // judul
              const Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 0.0),
                child: Text(
                  'Lihat Item',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: database.map((InventoryItem inventoryItem) {
                  return InventoryItemCard(inventoryItem);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InventoryItemCard extends StatelessWidget {
  final InventoryItem inventoryItem;

  const InventoryItemCard(this.inventoryItem, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(56, 182, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Text(
                inventoryItem.name,
                textAlign: TextAlign.left,
                
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                
              ),
              Text("Amount: ${inventoryItem.amount}"),
              Text("Harga: ${inventoryItem.price}"),
              Text("Description: ${inventoryItem.description}")
            ])));

    //;
  }
}
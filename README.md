<h1>Investment Inventory (Mobile Version)</h1>

<h2>Tugas 7</h2>

### 1. Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
**Stateless widget** (widget statis) adalah widget yang seluruh konfigurasi di dalamnya telah diinisiasi sejak awal tidak memiliki keadaan internal sehingga widget ini tidak dapat berubah sekali dibuat. Stateless widget cocok digunakan untuk bagian antarmuka pengguna yang tidak memerlukan perubahan atau interaksi dinamis.

**Stateful Widget** (widget dinamis) adalah widget yang dapat mengolah keadaan internal sehingga dapat diperbaharui kapanpun ketika dibutuhkan melalui user actions atau ketika terjadi perubahan data. Stateful widget cocok digunakan untuk bagian antarmuka pengguna yang memerlukan perubahan atau interaksi dinamis.

### 2. Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
- **MaterialApp** berfungsi sebagai akar dari aplikasi Flutter yang dirancang menggunakan desain Material Design dari Google. MaterialApp menyediakan berbagai pengaturan dan konfigurasi untuk aplikasi, seperti tema, rute, dan banyak lagi.
- **Material** berfungsi untuk memberi warna pada latar belakang kartu
- **MyHomePage** berfungsi widget halaman utama aplikasi
- **Text** berfungsi untuk menampilkan teks
- **Column** berfungsi untuk mengatur widget dalam kolom vertikal
- **AppBar** berfungsi untuk menampilkan bilah atas di aplikasi
- **Scaffold** berfungsi untuk membuat tata letak dasar aplikasi
- **GridView** untuk menampilkan elemen dalam tata letak grid
- **GridView.count** untuk membuat grid layout dengan jumlah kolom yang didefinikan.
- **Padding** untuk menambah jarak di sekitar widget anaknya
- **SnackBar** untuk menampilkan pesan sementara ketika kartu diklik
- **Container** untuk mengatur tata letak dan dekorasi widget anak di dalamnya. Anda dapat mengatur properti-properti seperti warna latar belakang, padding, margin, dan sebagainya menggunakan widget Container. 
- **InkWell** untuk memberi efek respons ketika kartu diklik. Biasanya digunakan di sekitar widget lain, seperti Text, Image, atau Container.
- **Center** Center adalah widget yang digunakan untuk mengatur widget anaknya agar berada di tengah dari tata letak (layout) orang tua, baik secara horizontal maupun vertikal. 
- **Icon** untuk menampilkan simbol dalam antarmuka pengguna Anda.
- **ItemCard** untuk menampilkan setiap elemen dalam grid sebagai kartu
- **SingleChildScrollView** untuk membuat area scrollable vertikal yang hanya memiliki satu widget anak.

## Cara Implementasi
1. Install Flutter melalui [link ini.](https://docs.flutter.dev/get-started/install/windows)
Buat project bernama `investment_inventory` dengan cara menjalankan kode di bawah ini pada command prompt:
```bash
flutter create investment_inventory
cd investment_inventory
flutter run
```

2. Buka direktori `investment_inventory/lib` dan tambahkan file `menu.dart`. Pastikan juga terdapat file `main.dart`

3. Isi lah file `menu.dart` dengan kode dibawah ini
```dart
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
      final List<ShopItem> items = [
      ShopItem("Lihat Item", Icons.checklist, Colors.blue),
      ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.green),
      ShopItem("Logout", Icons.logout, Colors.red),
    ];

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List',),
      ),
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

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

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
                  size: 30.0,
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
```

3. Isi lah file `main.dart` dengan kode dibawah ini
```dart
import 'package:flutter/material.dart';
import 'package:investment_inventory/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ), // ThemeData
      home: MyHomePage(),
    ); // MaterialApp
  }
}
```

4. [Bonus] Tambahkan variable color untuk memberikan warna yang berbeda pada ketiga tombol dengan kode dibawah ini pada file `menu.dart`
```dart
class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
      final List<ShopItem> items = [
      ShopItem("Lihat Item", Icons.checklist, Colors.blue),
      ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.green),
      ShopItem("Logout", Icons.logout, Colors.red),
    ];
    ...
}
```
```dart
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
```



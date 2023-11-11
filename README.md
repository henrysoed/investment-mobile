<h1>Investment Inventory (Mobile Version)</h1>

<h1>Tugas 8</h1>

### 1. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()`, disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
**Navigator.push()** digunakan untuk menampilkan halaman baru dengan cara menambahkan route baru ke paling atas stack route sehingga pengguna dapat kembali ke halaman sebelumnya karena route sebelumnya tetap ada di dalam tumpukan.<br>
Contoh penggunaan:
```dart
Navigator.push(context, MaterialPageRoute(builder: (context) => PageName()))
```

**Navigator.pushReplacement()** digunakan untuk menampilkan halaman baru dengan cara menggantikan route yang berada di posisi paling atas stack dengan route baru tersebut sehingga pengguna tidak dapat kebali ke halaman sebelumnya dengan mudah karena route sebelumnya sudah dihapus dari tumpukan. <br>
Contoh penggunaan:
```dart
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PageName()))
```

### 2. Jelaskan masing-masing *layout* widget pada Flutter dan konteks penggunaannya masing-masing!
1. Row
   - Mengatur elemen secara horizontal dari kiri ke kanan
   - Penggunaan: penataan tombol dan judul pada navigasi dalam baris

2. Column
   - Mengatur elemen secara vertikal dari atas ke bawah
   - Penggunaan: menata daftar item pada formulir

3. Center
   - Meletakkan elemen di tengah
   - Penggunaan: meletakkan elemen di tengah layar

4. Container
   - Sebagai wadah untuk mengatur tata letak dan gaya elemen pada aplikasi seperti padding, margin, borders, dan color
   - Penggunaan: memberi padding, margin, border, dan color pada elemen

5. ListView
   - Membuat daftar yang dapat discroll
   - Penggunaan: daftar item yang sangat panjang

6. Align
    - Mengatur posisi *align* dari child terhadap elemen parentnya.
    - Penggunaan: ketika ingin meletakkan tombol di pojok kanan bawah layar

7. Expanded
   - Digunakan di dalam Row atau Column untuk mengatur bagian yang mengisi sisi ruang yang tersedia
   - Penggunaan: ketika ingin membagi ruang yang tersedia secara proporsional antara beberapa elemen

8. Sizedbox
   - Menentukan ukuran lebar dan tinggi dari sebuah widget
   - Penggunaan: mengatur ruang kosong atau mengontrol ukuran elemen dalam tata letak Anda

9. Card
   - Untuk mengelilingi elemen-elemen seperti gambar, teks, atau tombol untuk membuat tampilan kartu
   - Penggunaan: sering digunakan dalam daftar item atau dalam konteks informasi yang terkandung dalam satu blok visual

10. GridView
    - Menampilkan elemen dalam tata letak berbentuk grid atau tabel. Kita dapat megnatur jumlah kolom, menggulir elemen-elemen dalam grid, dan mengontrol tampilan yang berbeda untuk setiap elemen
    - Pengunaan: ketika ingin menampilakn elemen dalam bentuk tabel

11. Wrap
    - Mengatur elemen-elemen dalam baris atau kolom yang berjajar tetapi elemen-elemen tersebut tidak muat dalam baris atau kolom tersebut, sehingga mereka melanjutkan ke baris atau kolom berikutnya
    - Penggunaan: menata elemen yang ingin dilanjutkan ke baris atau kolom berikutnya
 
12. Stack
   - Menumpuk elemen-elemen di atas satu sama lain
   - Penggunaan: ketika ingin menumpuk gambar, icon, dan teks di satu tumpukan

13. Baseline
    - Mengatur posisi suatu elemen sehingga *baseline*/garis dasarnya sejajar
    - Pengunaan: ketika ingin memposisikan elemen terhadap garis dasarnya

14. Padding
    - Menambahkan jarak (padding) di sekeliling anaknya
    - Penggunaan: mengatur ruang antara elemen-elemen dalam tata letak

15. Transform
    - Mentransformasikan atau mengubah elemen-elemen anaknya seperti menggeser, memutar, atau mengubah ukuran mereka.
    - Penggunaan: membuat efek visual atau animasi

### 3. Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Elemen input yang saya gunakan pada tugas kali ini adalah `TextFormField`. Elemen ini saya gunakan untuk menerima input nama item, jumlah, harga, dan deskripsi pada form untuk tambah item. Saya menggunakan elemen `TextFormField` karena elemen tersebut dapat digunakan untuk menerima input berupa teks dari pengguna. Selain itu, saya juga menggunakan `validator` untuk memastikan bahwa input tidak kosong dan sesuai dengan yang diminta (misal harga, dan jumlah harus berupa angka)

### 4. Bagaimana penerapan *clean architecture* pada aplikasi Flutter?
**Clean Architecture** adalah pendekatan software development yang memisahkan kode ke dalam lapisan-lapisan yang independen dan saling bergantung satu sama lain sehingga membantu developer untuk menerapkan pengembangan aplikasi yang lebih terstruktur, mudah diuji, dan mudah dipelihara.<br>

Penerapan clean architecture pada aplikasi Flutter merupakan prinsip seperti Separation of Concern pada MVP, MVT, atau MVCC. <br>
Pembagiannya sebagai berikut: <br>

+ Domain
  + Entities
  + Usecases
  + Repositories

+ App
  + View
  + Controller
  + Presenter
  + Extra

+ Data
  + Repositories
  + Models
  + Mappers
  + Extra

+ Device
  + Devices
  + Extra

## Cara Implementasi
1. Tambahkan endDrawer pada Scaffold di dalam file `menu.dart` untuk membuat drawer pada aplikasi sehingga dapat mengakses berbagai macam halaman dengan mudah
```dart
return Scaffold(
  appBar: ...
  endDrawer: const LeftDrawer(),
  body: ...
```

2. Buatlah file baru dengan nama `left_drawer.dart` yang berisi kode dibawah ini
```dart
import 'package:flutter/material.dart';
import 'package:investment_inventory/screens/menu.dart';
// TODO: Impor halaman ShopFormPage jika sudah dibuat
import 'package:investment_inventory/screens/shoplist_form.dart';
import 'package:investment_inventory/screens/list_item.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Investment Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Write all your investment portofolio",
                  // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
           ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Lihat Item'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListItemPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_add_outlined),
            title: const Text('Tambah Item'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryFormPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
```

2. Buatlah halaman form untuk menambah item pada file `shoplist_form.dart` dengan StatefulWidget `InventoryFormPage` seperti kode dibawah ini
```dart
import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:investment_inventory/widgets/left_drawer.dart';
import 'package:investment_inventory/screens/list_item.dart';
import 'package:investment_inventory/screens/menu.dart';

class InventoryFormPage extends StatefulWidget {
  const InventoryFormPage({super.key});

  @override
  State<InventoryFormPage> createState() => _InventoryFormPageState();
}

class _InventoryFormPageState extends State<InventoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  int _price = 0;
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Item',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Produk",
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Amount",
                  labelText: "Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                // TODO: Tambahkan variabel yang sesuai
                onChanged: (String? value) {
                  setState(() {
                    _amount = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Amount tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Amount harus berupa angka!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Harga",
                  labelText: "Harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                // TODO: Tambahkan variabel yang sesuai
                onChanged: (String? value) {
                  setState(() {
                    _price = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Harga harus berupa angka!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    // TODO: Tambahkan variabel yang sesuai
                    _description = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                    setState(() {
                      WiListItemPage.database.add(InventoryItem(_name, _amount, _price, _description));
                    });

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Produk berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  // TODO: Munculkan value-value lainnya
                                  Text('Amount: $_amount'),
                                  Text('Harga: $_price'),
                                  Text('Deskripsi: $_description')
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    _formKey.currentState!.reset();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
```

4. [Bonus] Buatlah file baru bernama `list_item.dart` untuk melihat daftar item yang telah dibuat, seperti kode dibawah ini
```dart
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
```

5. Arahkan user ke halaman yang sesuai ktika user menekan tombol `Lihat Item` dan `Tambah Item` pada halaman utama
```dart
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
          ...
```

<details>
<summary>Tugas 7</summary>

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
</details>



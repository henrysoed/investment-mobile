<h1>Investment Inventory (Mobile Version)</h1>

<h1>Tugas 9</h1>

### 1. Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Kita dapat melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Pendekatan ini biasanya disebut sebagai "parsing JSON". Hal yang lebih baik bergantung pada kebutuhan dan tujuan kita dalam membuat suatu program.
Membangun model diperlukan jika tujuannya untuk menganalisis data lebih lanjut, memprediksi pola, atau membuat rekomendasi berdasarkan data tersebut. Sedangkan jika tujuannya hanya untuk mengakses atau menampilkan data JSON yang diterima dari suatu API atau sumber data lainnya, lebih baik tidak membuat model.

### 2. Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

**CookieRequest** berfungsi untuk mengelola permintaan request yang melibatkan cookie dalam aplikasi. Kelas ini bertanggung jawab untuk mengatur informasi terkait sesi pengguna yang disimpan di sisi klien melalui cookie.

Instance CookieRequest perlu dibagikan ke semua komponen untuk memastikan bahwa manajemen cookie dilakukan secara seragam di seluruh komponen. Dengan cara ini, pengelolaan sesi pengguna dapat dipelihara dengan konsistensi di seluruh aplikasi, memastikan bahwa data sesi dan perilaku terkait cookie dapat diandalkan dan dikelola dengan baik.


### 3. Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
1. Gunakan package dan library yang diperlukan, contohnya http dan convert.
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
```
2. Fetch data menggunakan HTTP untuk meminta data dari server yang memiliki data JSON tersebut.
```dart
  Future<List<Item>> fetchItem() async {
    var response = await http.get(
      Uri.parse(
        //'http://henry-soedibjo-tugas.pbp.cs.ui.ac.id/json/'
        'http://127.0.0.1:8000/json/'
        //'http://127.0.0.1:8000/get-flutter/'
        );,
      headers: {"Content-Type": "application/json"},
    );
  }
```

3. Parsing atau convert response tersebut ke dalam bentuk JSON.
```dart
Future<void> getData() async {
  try {
    var jsonData = await fetchData();
    List<dynamic> dataList = jsonData.body;

  } catch (e) {
    print('Error: $e');
  }
}
```

4. Menampilkan data di flutter contohnya menggunakan ListView.builder

```dart
ListView.builder(
  itemCount: dataList.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(dataList[index]['title']),
      subtitle: Text(dataList[index]['subtitle']),
    );
  },
);
```

### 4. Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
1. Buatlah instance CookieRequest menggunakan pbp_django_auth di Flutter dan menyimpannya dalam variabel request
```dart
final request = context.watch<CookieRequest>();
```
2. Selanjutnya, pada halaman `login.dart` saat pengguna mengirimkan formulir dengan username dan password, kita menggunakan instance request untuk melakukan permintaan login ke server Django
```dart
final response = await request.login(
  "http://127.0.0.1:8000/auth/login/",
  {
    'username': username,
    'password': password
  }
);
```
3. Di sisi server Django, kita memproses permintaan login dalam view login
```dart
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login as auth_login

@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)
```

### 5. Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
1. TextField
Widget ini digunakan untuk menerima input teks dari pengguna. Pada tugas ini, digunakan untuk menerima username dan password saat proses login dan registrasi.

2. SizedBox
Widget ini digunakan untuk memberikan ruang tertentu atau pemisah antara elemen-elemen dalam antarmuka pengguna. Pada tugas ini, digunakan untuk memberikan jarak atau ruang antara widget TextField username dan password.

3. ElevatedButton
Widget ini menciptakan tombol dengan efek elevasi yang terjadi saat tombol ditekan. Pada tugas ini, ElevatedButton digunakan sebagai tombol submit pada proses login dan registrasi, memicu aksi yang sesuai ketika ditekan.

4. TextButton
Widget ini menciptakan tombol berupa teks tanpa latar belakang. Pada tugas ini, TextButton digunakan sebagai tombol registrasi, memberikan opsi alternatif selain login.

5. ListView.builder
Widget ini digunakan untuk membuat daftar item yang dapat discroll. Pada tugas ini, digunakan untuk menampilkan daftar item yang ada, seperti daftar hasil pencarian atau item dalam kategori tertentu.

6. Text
Widget ini digunakan untuk menampilkan teks di antarmuka pengguna. Pada tugas ini, digunakan untuk menampilkan teks detail saat item pada daftar item ditekan, memberikan informasi lebih lanjut tentang item tersebut.

## Cara Implementasi
### Buka Proyek Django `TUGAS2`
1. Buka file `requirements.txt` tambahkan `django-cors-headers` dan jalankan `pip install -r requirements.txt` pada terminal

2. Tambahkan `corsheaders.middleware.CorsMiddleware` pada `settings.py` aplikasi Django serta variabel berikut
```py
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```

3. Buat app baru bernama `authentication`, pada `urls.py`, buatlah path menuju login, logout, dan register. Jangan lupa hubungkan ke `INSTALLED_APPS` pada `settings.py`.
```py
from django.urls import path
from authentication.views import login, logout, register

app_name = 'authentication'

urlpatterns = [
    path('login/', login, name='login'),
    path('logout/', logout, name='logout'),
    path('register/', register, name='register'),
]
```

4. Pada `views.py`, buatlah kode berikut:
```py
from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.forms import UserCreationForm

@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)

@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout gagal."
        }, status=401)
    
@csrf_exempt
def register(request):
        
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return JsonResponse({'message': 'User registered successfully'})
        else:
            return JsonResponse({'errors': form.errors}, status=400)
    return JsonResponse({'message': 'Invalid request'}, status=400)

```
5. Tambahkan `path('auth/', include('authentication.urls'))`, pada file `investment_inventory/urls.py`.

6. Tambahkan fungsi views baru pada `main/views.py`.
```py
@csrf_exempt
def create_product_flutter(request):
    if request.method == 'POST':
        data = json.loads(request.body)

        new_product = Item.objects.create(
            user = request.user,
            name = data["name"],
            amount = int(data["amount"]),
            description = data["description"]
        )

        new_product.save()

        return JsonResponse({"status": "success"}, status=200)
    
    else:
        return JsonResponse({"status": "error"}, status=401)
```
dan pathnya `path('create-flutter/', create_product_flutter, name='create_product_flutter'),`

## Buka Proyek Flutter `INVESTMENT_INVENTORY`

7.Install package yang telah disediakan dengan menjalankan perintah berikut di terminal
```bash
flutter pub add provider
flutter pub add pbp_django_auth
```

8. Buatlah `login.dart` pada folder `screens` yang berisi:
```dart
import 'package:investment_inventory/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:investment_inventory/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// void main() {
//     runApp(const LoginApp());
// }

class LoginApp extends StatelessWidget {
const LoginApp({super.key});

@override
Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        theme: ThemeData(
            primarySwatch: Colors.blue,
    ),
    home: const LoginPage(),
    );
    }
}

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: const Text('Login'),
            ),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                            ),
                        ),

                        const SizedBox(height: 12.0),

                        TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                            ),
                            obscureText: true,
                        ),

                        const SizedBox(height: 24.0),

                        ElevatedButton(
                            onPressed: () async {
                                String username = _usernameController.text;
                                String password = _passwordController.text;

                                // Cek kredensial
                                // Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                // gunakan URL http://10.0.2.2/
                                final response = await request.login("http://127.0.0.1:8000/auth/login/"
                                  , {
                                'username': username,
                                'password': password,
                                });
                    
                                if (request.loggedIn) {
                                    String message = response['message'];
                                    String uname = response['username'];
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                            SnackBar(content: Text("$message Selamat datang, $uname.")));
                                    } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: const Text('Login Gagal'),
                                            content:
                                                Text(response['message']),
                                            actions: [
                                                TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                    },
                                                ),
                                            ],
                                        ),
                                    );
                                }
                            },
                            child: const Text('Login'),
                        ),


                        const SizedBox(height: 24.0),


                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                                    );
                          },
                          child: const Text("Register"))
                    ],
                ),
            ),
        );
    }
}
```

9. Arahkan `menu.dart` ke login sebagai halaman yang pertama kali muncul serta menambahkan provider dan CookieRequest.
```dart
class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
            child: MaterialApp(
                title: 'Flutter App',
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                    useMaterial3: true,
                ),
                home: LoginPage()),
            ),
        );
    }
}
```

10. Buatlah `register.dart` yang berisi:
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    final url = Uri.parse("http://127.0.0.1:8000/auth/register/"
        );
    final response = await http.post(
      url,
      body: {
        'username': _usernameController.text,
        'email': _emailController.text,
        'password1':
            _passwordController.text, // Modify to match Django form fields
        'password2':
            _passwordController.text, // Modify to match Django form fields
      },
    );

    if (response.statusCode == 200) {
      // Handle successful registration
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User registered successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle registration errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to register user.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regisration Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                // String username = _usernameController.text;
                // String password = _passwordController.text;

                await _registerUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

```

11. Tambahkan kode dibawah ini pada `item_card.dart`:
```dart
if (tombol.name == "Tambah Item") {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const InventoryFormPage()));

} else if (tombol.name == "Lihat Item") {
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => const ItemPage()));
      
}
else if (tombol.name == "Logout") {
  final response = await request.logout(
      "http://127.0.0.1:8000/auth/logout/"
      );
  String message = response["message"];
  if (response['status']) {
    String uname = response["username"];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message Sampai jumpa, $uname."),
    ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
    ));
  }
}
```

12. Buatlah model kustom, buka situs web [QuickType](https://app.quicktype.io/). Copy data JSON pada projek Django dan paste pada textbox pada QuickType. ubah setup name menjadi `Item`, source type `JSON`, dan language `Dart`. Pindahkan hasilnya ke dalam file dart baru `lib/models/product.dart`.

Jalankan `flutter pub add http` pada terimal.

13. Pada file `android/app/src/main/AndroidManifest.xml`, tambahkan kode berikut untuk memperbolehkan akses internet pada apliaksi Flutter yang dibuat.
```xml
...
    <application>
    ...
    </application>
    <!-- Required to fetch data from the Internet. -->
    <uses-permission android:name="android.permission.INTERNET" />
...
```

14. Buka file `list_item.dart`,dan masukkan kode berikut:
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:investment_inventory/models/product.dart';

import 'package:investment_inventory/widgets/left_drawer.dart';

class ProductPage extends StatefulWidget {
    const ProductPage({Key? key}) : super(key: key);

    @override
    _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
Future<List<Product>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(Product.fromJson(d));
        }
    }
    return list_product;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.amount}"),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.price}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}
```

15. Untuk menampilkan detail item saat item diklik, buatlah `detail.dart` yang berisi:
```dart
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String pk;
  final String name;
  final String amount;
  final String description;
  final String dateAdded;

  const Detail(
      {super.key,
      required this.pk,
      required this.name,
      required this.amount,
      required this.description,
      required this.dateAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Item'),
        ),
        //endDrawer: const RightDrawer(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text("pk: $pk"),

              const SizedBox(height: 20),

              Text("Item amount: $amount"),

              const SizedBox(height: 20),

              Text("Item description: $description"),

              const SizedBox(height: 20),

              Text("Date added: $dateAdded"),
            ],
          ),
          )
          
        ));
  }
}

```

<details>
<summary>Tugas 8</summary>

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
</details>

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



# Tugas 7 PBP - Naomyscha Attalie Maza (2406348433)

### 💡 1. Apa itu widget tree di Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget?

Widget tree itu bisa dibilang seperti **struktur pohon** dari semua elemen yang ada di aplikasi Flutter.
Setiap tampilan di Flutter (seperti teks, tombol, atau gambar) adalah **widget**, dan mereka saling berhubungan secara hierarki, ada yang jadi **parent (induk)** dan ada yang jadi **child (anak)**.

Misalnya:

Scaffold
 |_ AppBar
 |_ Body (Column)
    |_ Text
    |_ Row
       |_ Icon
       |_ Text

Di sini `Scaffold` adalah induk dari `AppBar` dan `Column`. Lalu `Column` jadi induk dari `Text` dan `Row`, dan seterusnya.
Parent mengatur bagaimana child ditampilkan di layar, misalnya posisi, ukuran, atau gaya tampilannya.


### 🧱 2. Sebutkan semua widget yang digunakan dan fungsinya

Berikut widget yang aku pakai dan fungsinya:

* **MaterialApp** → membungkus seluruh aplikasi supaya pakai gaya *Material Design* dari Flutter.
* **Scaffold** → kerangka utama halaman (ada AppBar dan body).
* **AppBar** → bagian header di atas layar, tempat judul “Football Shop”.
* **Column** → menyusun widget secara vertikal (atas ke bawah).
* **Row** → menyusun widget secara horizontal (samping-sampingan).
* **Card** → bikin tampilan seperti kotak dengan bayangan (dipakai buat InfoCard).
* **Text** → menampilkan tulisan.
* **Icon** → menampilkan ikon di tombol.
* **GridView.count** → menampilkan tombol dalam bentuk grid (tiga kolom).
* **Material** & **InkWell** → supaya tombol punya efek klik (*ripple effect*).
* **SnackBar** → menampilkan pesan sementara di bawah layar setelah tombol ditekan.


### 🎨 3. Apa fungsi dari widget MaterialApp dan kenapa sering dipakai sebagai root?

`MaterialApp` itu seperti **pembungkus utama aplikasi Flutter**.
Dia mengatur tema warna, judul, rute halaman, dan gaya tampilan supaya sesuai dengan *Material Design* (standar tampilan Android/Google).
Makanya `MaterialApp` sering dipakai sebagai **widget root**, karena semua widget di bawahnya bisa pakai tema dan pengaturan global dari situ.


### ⚖️ 4. Jelaskan perbedaan StatelessWidget dan StatefulWidget, dan kapan dipakai

* **StatelessWidget** → isinya *statis*, tidak berubah saat aplikasi berjalan.
  Contohnya: halaman informasi, teks, ikon, tombol yang cuma tampil tanpa data yang berubah.
* **StatefulWidget** → isinya bisa *berubah* (punya “state”).
  Contohnya: counter, form input, list yang bisa di-update, dll.

Di tugas ini aku pakai **StatelessWidget**, karena isi halamannya tidak berubah, cuma tampilan dan tombol statis saja.


### 🧠 5. Apa itu BuildContext dan kenapa penting di Flutter?

`BuildContext` itu semacam **penanda lokasi widget di dalam tree aplikasi**.
Dia penting karena lewat `context`, Flutter tahu posisi widget di struktur dan bisa “akses” hal-hal di sekitarnya.
Contoh penggunaannya:

* `Theme.of(context)` → mengambil warna tema aplikasi.
* `ScaffoldMessenger.of(context)` → buat memunculkan `SnackBar`.
* `Navigator.of(context)` → buat pindah halaman.

Jadi `context` wajib ada di method `build()` biar widget tahu lingkungan tempat dia berada.


### 🔁 6. Jelaskan konsep “hot reload” dan bedanya dengan “hot restart”

* **Hot reload** → memperbarui tampilan aplikasi *tanpa kehilangan state/data*.
  Cocok kalau cuma ubah tampilan, warna, atau teks kecil.
* **Hot restart** → nge-*restart* ulang aplikasi dari awal. Semua state/data akan hilang.
  Biasanya dipakai kalau ubah struktur besar di kode (misal nambah variabel global, ubah logic utama).

# Tugas 8 PBP - Naomyscha Attalie Maza (2406348433)

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() dan Navigator.pushReplacement() sama-sama digunakan untuk navigasi antar halaman (route), tetapi fungsinya sedikit berbeda:

- Navigator.push()
Menambahkan halaman baru di atas stack halaman yang sudah ada. Halaman sebelumnya masih tersimpan di bawah dan pengguna bisa kembali ke halaman sebelumnya dengan menekan tombol "Back".
Contoh penggunaan: ketika pengguna menekan tombol "Create Product", digunakan Navigator.push() supaya setelah mengisi form, mereka bisa kembali ke halaman utama dengan mudah.

- Navigator.pushReplacement()
Mengganti halaman saat ini dengan halaman baru (halaman lama dihapus dari stack). Pengguna tidak bisa kembali ke halaman sebelumnya.
Contoh penggunaan: pada drawer, ketika pengguna memilih "Halaman Utama" atau "Tambah Produk", digunakan Navigator.pushReplacement() supaya halaman tidak menumpuk di stack dan navigasi terasa lebih efisien.


2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya memanfaatkan hierarki widget untuk menjaga agar seluruh halaman aplikasi memiliki struktur dan gaya yang konsisten.

- Scaffold digunakan sebagai kerangka utama setiap halaman, berisi AppBar, Drawer, dan body. Semua halaman dimulai dengan Scaffold agar memiliki struktur dasar yang sama.

- AppBar digunakan sebagai header di atas layar untuk menampilkan judul aplikasi "Soccerella". Semua halaman memiliki AppBar dengan gaya dan warna seragam agar pengguna tahu masih berada di dalam aplikasi yang sama.

- Drawer digunakan sebagai menu navigasi utama di sisi kiri layar. Drawer berisi dua opsi, yaitu "Halaman Utama" dan "Tambah Produk", untuk memudahkan pengguna berpindah halaman.

Dengan struktur tersebut, setiap halaman memiliki tampilan yang seragam dengan AppBar di atas, Drawer di kiri, dan konten utama di tengah.


3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Ketiga widget tersebut membantu tampilan form menjadi rapi, nyaman, dan responsif di berbagai ukuran layar.

- Padding digunakan untuk memberikan jarak antar elemen agar tidak terlalu rapat.
Contoh: setiap TextFormField pada form tambah produk dibungkus dengan Padding agar tampilan antar input lebih rapi dan mudah dibaca.

- SingleChildScrollView digunakan agar halaman bisa di-scroll saat konten melebihi tinggi layar.
Contoh: pada form tambah produk yang memiliki banyak input field, SingleChildScrollView digunakan untuk mencegah overflow dan memungkinkan pengguna menggulir ke bawah.

- ListView digunakan di dalam Drawer untuk menampilkan daftar menu (Home dan Tambah Produk) secara vertikal dan bisa di-scroll.
Contoh: pada file left_drawer.dart, menu navigasi ditampilkan menggunakan ListView agar tetap bisa diakses walaupun layar kecil.

Dengan kombinasi ketiganya, form terlihat lebih rapi dan user-friendly di berbagai perangkat.


4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Warna tema disesuaikan agar aplikasi memiliki identitas visual yang seragam dengan konsep brand "Soccerella", yaitu modern, energik, dan sporty.

Beberapa penyesuaian yang dilakukan:

- Menggunakan warna biru sebagai warna utama (primaryColor) untuk mencerminkan profesionalisme dan kepercayaan. Warna ini digunakan di AppBar dan DrawerHeader.

- Menggunakan warna hijau pada halaman form untuk memberikan kesan segar dan identik dengan lapangan sepak bola.

- Memberikan warna merah pada tombol "Create Product" agar menonjol dan mudah dikenali pengguna.

- Menggunakan teks berwarna putih dengan huruf tebal di atas latar biru atau hijau agar kontras dan mudah dibaca.

Dengan penyesuaian warna yang konsisten, aplikasi menciptakan identitas visual yang serasi dan merepresentasikan karakter brand toko.
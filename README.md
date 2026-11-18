# MyPortfolio Mobile

Aplikasi portofolio pribadi milik Kayla berbasis Flutter. Halaman utama menampilkan informasi mengenai Kayla dan tiga kartu aksi: Lihat Proyek, Tambah Proyek, dan Logout. Setiap kartu memiliki warna, ikon, dan SnackBar.

## Teknologi

- Flutter dan Dart
- Material Design
- Google Chrome untuk menjalankan versi web

## Cara Menjalankan

Pastikan Flutter SDK dan Google Chrome sudah terpasang. Dari root folder proyek:

```bash
flutter pub get
flutter run -d chrome
```

## Tugas 7

### 1. Widget tree dan hubungan parent-child
Widget tree adalah susunan widget secara bertingkat yang membentuk tampilan aplikasi Flutter. Widget parent dapat mengatur tata letak atau perilaku widget child. Contohnya, Scaffold menjadi kerangka halaman yang berisi AppBar dan body. Di dalam body, Column menyusun beberapa child secara vertikal, sedangkan Row menyusunnya secara horizontal.

### 2. Widget yang digunakan dan fungsinya
MaterialApp: konfigurasi dasar aplikasi Material dan tema.
Scaffold: kerangka dasar halaman, termasuk AppBar dan body.
AppBar: menampilkan bilah judul di bagian atas.
Padding: memberikan jarak di sekitar widget.
Column: menyusun child secara vertikal.
Row: menyusun child secara horizontal.
Center: menengahkan child.
Text: menampilkan tulisan.
Icon: menampilkan ikon.
SizedBox: memberi jarak dengan ukuran tertentu.
Card: menampilkan kartu informasi.
Container: mengatur ukuran, padding, dan isi kartu.
GridView.count: menyusun kartu aksi dalam kisi.
Material: menyediakan permukaan bergaya Material dan warna latar kartu.
InkWell: menangani sentuhan pada kartu aksi.
SnackBar: menampilkan pesan sementara setelah kartu ditekan.
Proyek ini juga memiliki widget buatan sendiri: MyApp, MyHomePage, InfoCard, dan ItemCard. ItemHomepage adalah model data untuk menyimpan nama, ikon, dan warna setiap tombol aksi.

### 3. Fungsi MaterialApp
MaterialApp menyediakan konfigurasi umum aplikasi Material, seperti tema dan halaman awal. Widget ini biasanya menjadi root agar halaman-halaman di bawahnya dapat menggunakan konfigurasi tersebut.

### 4. Perbedaan StatelessWidget dan StatefulWidget
StatelessWidget digunakan ketika tampilan tidak mengelola state lokal yang berubah. StatefulWidget digunakan ketika perubahan state perlu memperbarui tampilan, misalnya nilai penghitung yang berubah setelah tombol ditekan. Halaman menu proyek ini menggunakan StatelessWidget karena informasi yang ditampilkan bersifat tetap.

### 5. BuildContext
BuildContext menunjukkan posisi sebuah widget di dalam widget tree. Context penting untuk mengakses informasi dari widget di atasnya. Di proyek ini, Theme.of(context) mengambil tema aplikasi, MediaQuery.of(context) mengambil ukuran layar, dan ScaffoldMessenger.of(context) digunakan untuk menampilkan SnackBar.

### 6. Hot reload dan hot restart
Hot reload menerapkan perubahan kode tanpa memulai ulang seluruh aplikasi dan umumnya mempertahankan state yang sedang berjalan. Hot restart menjalankan ulang aplikasi dari awal sehingga state di-reset. Perubahan inisialisasi awal atau konfigurasi native/plugin mungkin memerlukan hot restart atau full restart.

### AI Disclosure
Saya menggunakan OpenAI ChatGPT untuk membantu memahami instruksi IA 7, mendiskusikan penerapan warna kartu, memeriksa beberapa bagian implementasi, dan menyusun draf dokumentasi serta refleksi. Saya memberikan konteks berupa instruksi tugas dan kode yang relevan, lalu meminta bantuan secara bertahap untuk menjelaskan atau memeriksa bagian tertentu.

Saya meninjau saran yang diberikan dan memeriksa aplikasi di Chrome. Kode juga diperiksa dengan menjalankan flutter analyze. AI dapat memberikan saran yang tidak sesuai dengan kondisi proyek, sehingga hasilnya tetap saya periksa terhadap instruksi tugas dan implementasi aktual.

Log chat: https://chatgpt.com/share/6af9c10c-667c-83ec-bbb2-7153559af701
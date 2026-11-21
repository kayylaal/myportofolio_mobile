# MyPortfolio Mobile

Aplikasi portofolio pribadi milik Kayla berbasis Flutter. Halaman utama menampilkan informasi mengenai Kayla dan empat kartu aksi: Lihat Proyek, Tambah Proyek, Tambah Social Work, dan Logout. Setiap kartu memiliki warna, ikon, dan SnackBar.

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


## Tugas 8

## Progres Mingguan
- Membuat formulir Social Work dengan validasi judul, deskripsi, URL foto, dan tahun kegiatan.
- Menambahkan akses ke formulir melalui kartu aksi halaman utama dan drawer.
- Menambahkan dialog ringkasan setelah input lolos validasi.
- Menjalankan `flutter analyze` untuk memeriksa kode.

### 1. Perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode yang digunakan untuk membuka formulir dari kartu aksi. Bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.
`Navigator.push()` menambahkan halaman baru ke atas navigation stack, sehingga user dapat kembali ke halaman sebelumnya dengan tombol kembali. Kartu Tambah Social Work dan Proyek menggunakan `push()` untuk membuka formulir. `Navigator.pushReplacement()` mengganti halaman saat ini dengan halaman baru, seperti opsi Home pada drawer yang mengarahkan pengguna kembali ke halaman utama. `Navigator.pop()` menutup halaman atau dialog yang sedang berada di atas stack.

### 2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten. Contoh penggunaan warna tema portofolio di lebih dari satu halaman.
`Scaffold` menyediakan struktur dasar halaman, termasuk `AppBar`, `Drawer`, dan `body`. Penggunaan struktur dan drawer yang sama menjaga navigasi halaman utama dan formulir tetap konsisten. Contohnya, warna hitam `0xFF060201` digunakan pada AppBar halaman utama dan formulir Social Work, sedangkan warna latar krem `0xFFFFF8ED` digunakan sebagai warna tema aplikasi.

### 3. Alasan tata letak tersebut dipilih untuk formulir. Peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.
Formulir menggunakan `SingleChildScrollView` agar semua kolom dan tombol Simpan tetap bisa dijangkau ketika ruang layar terbatas atau keyboard tampil. `Padding` memberi jarak di sekitar input sehingga formulir lebih mudah dibaca dan digunakan.

### 4. Peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan. Contoh nilai yang ditolak oleh validasi dan mengapa memilih jenis input atau papan ketik saja belum cukup.
4. `GlobalKey<FormState>` menghubungkan tombol Simpan dengan state formulir. Setiap field memiliki validator, lalu `validate()` memeriksa semua input ketika tombol Simpan ditekan. Contohnya, judul yang kosong atau hanya berisi spasi ditolak. Keyboard angka pada field tahun membantu memasukkan angka, tetapi tidak cukup untuk memastikan nilainya benar karena pengguna masih dapat menempelkan teks; karena itu validator tetap memeriksa bahwa input dapat diubah menjadi angka dan tahun berada dalam rentang yang ditentukan. Field judul juga dibatasi maksimal 255 karakter sesuai model Social Work.

### AI Disclosure
Saya menggunakan model OpenAI untuk membantu menafsirkan checklist menjadi tahapan-tahapan yang mudah dipahami, meninjau implementasi formulir/navigasi, dan memberi saran validasi. Dalam pengerjaan ini, saya menuliskan kodenya sendiri dan setiap selesai satu tahapan saya meminta cek dulu sebelum commit.

Saya meninjau saran yang diberikan dan memeriksa aplikasi di Chrome dan menggunakan flutter analyze. AI dapat memberikan saran yang tidak sesuai dengan kondisi proyek, sehingga hasilnya tetap saya periksa terhadap instruksi tugas dan implementasi aktual.

Log chat: https://chatgpt.com/share/6b01c966-62dc-83ec-b96c-9742d2491d45


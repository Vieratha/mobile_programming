# Ivylodia

**Ivylodia** adalah aplikasi pemutar musik sederhana berbasis Flutter yang memungkinkan pengguna mencari lagu, mendengarkan preview musik, menyimpan lagu favorit, dan mengelola profil pengguna.

Aplikasi ini dibuat sebagai bagian dari tugas Mobile Programming dengan menerapkan konsep Flutter, pengelolaan state, responsive UI, API integration, dan JSON parsing.

## Fitur Aplikasi

### 1. Home
- Halaman utama aplikasi.
- Menampilkan kategori musik seperti Pop, R&B, dan Indie.
- Akses cepat menuju fitur pencarian musik.

### 2. Search Music
- Mencari lagu berdasarkan judul atau nama artis.
- Mengambil data musik dari iTunes Search API.
- Menampilkan judul lagu, nama artis, dan cover album.
- Menampilkan loading indicator saat mengambil data.
- Menampilkan notifikasi apabila terjadi kegagalan pengambilan data.

### 3. Music Player
- Memutar preview audio lagu.
- Play dan Pause.
- Next dan Previous.
- Menampilkan informasi lagu yang sedang diputar.
- Mini Player yang dapat diakses dari tampilan utama aplikasi.

### 4. Favorite & Your Library
- Menambahkan lagu ke daftar Favorite.
- Menghapus lagu dari Favorite.
- Menampilkan koleksi lagu favorit pada halaman Your Library.
- Menyimpan daftar Favorite agar tetap tersedia ketika aplikasi dibuka kembali.

### 5. User Profile
- Mengubah nama pengguna.
- Mengubah email.
- Mengubah bio.
- Memilih avatar.
- Menyimpan perubahan profil.

## Teknologi yang Digunakan

- **Flutter** – Framework pengembangan aplikasi.
- **Dart** – Bahasa pemrograman.
- **Material Design 3** – Komponen antarmuka.
- **HTTP** – Mengirim HTTP request untuk mengambil data API.
- **iTunes Search API** – Sumber data lagu dan informasi album.
- **JSON Parsing** – Mengolah respons API.
- **just_audio** – Memutar preview audio.
- **SharedPreferences** – Menyimpan data profil dan daftar Favorite secara lokal.

## API

Ivylodia menggunakan iTunes Search API untuk mengambil informasi lagu.

Endpoint:

`https://itunes.apple.com/search`

Parameter yang digunakan:
- `term`: kata kunci pencarian.
- `limit`: jumlah hasil pencarian.
- `entity`: jenis data yang dicari, yaitu `song`.

Data yang diperoleh kemudian diproses menggunakan JSON parsing untuk menampilkan informasi lagu pada aplikasi.

## Struktur Project

```text
lib/
├── main.dart
├── pages/
│   ├── home_page.dart
│   ├── search_page.dart
│   ├── library_page.dart
│   ├── now_playing_page.dart
│   └── profile_page.dart
├── services/
│   ├── music_api.dart
│   └── local_storage.dart
└── widgets/
    ├── app_header.dart
    ├── app_sidebar.dart
    ├── mini_player.dart
    └── song_tile.dart
```

## Cara Menjalankan Project

1. Clone repository:

   ```bash
   git clone https://github.com/Vieratha/mobile_programming.git
   ```

2. Masuk ke direktori aplikasi:

   ```bash
   cd mobile_programming/Tugas/tugaspertemuan11_musicplayer
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## Screenshots

Screenshot aplikasi dapat dilihat pada bagian dokumentasi repository ini.

---

**Ivylodia — Your Music, Your Moment.**

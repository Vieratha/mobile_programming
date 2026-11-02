import 'package:flutter/material.dart';

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      //Ini bagian Isi FAQ
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 10),

            //Ini bagian Judul FAQ
            Text(
              'FAQ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              '1. Bagaimana cara menyewa buku?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Untuk menyewa buku, pilih buku yang diinginkan, tekan tombol Rental, pilih durasi rental, lalu lakukan pembayaran.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            SizedBox(height: 18),

            Text(
              '2. Bagaimana cara membeli buku?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Pilih buku yang ingin dibeli, tekan tombol Beli, lalu selesaikan pembayaran.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            SizedBox(height: 18),

            Text(
              '3. Berapa lama masa rental buku?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Masa rental mengikuti durasi yang dipilih saat transaksi, seperti 7 hari, 14 hari, atau 30 hari.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            SizedBox(height: 18),

            Text(
              '4. Di mana saya dapat melihat buku yang telah saya sewa?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Buku yang sedang dirental dapat dilihat pada menu Koleksi > Rental.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            SizedBox(height: 18),

            Text(
              '5. Bagaimana cara mengubah password akun?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Buka menu Profil > Keamanan, lalu masukkan password lama dan password baru.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            SizedBox(height: 18),

            Text(
              '6. Bagaimana jika pembayaran berhasil tetapi buku belum masuk ke koleksi?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Periksa riwayat transaksi dan koneksi internet. Jika masalah berlanjut, hubungi layanan pelanggan.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
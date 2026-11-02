import 'package:flutter/material.dart';
import 'invoicePembelianPage.dart';
import 'riwayatRentalPage.dart';

class RiwayatPembelianPage extends StatelessWidget {
  const RiwayatPembelianPage({super.key});

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
          'Riwayat Transaksi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      //Ini bagian Isi Halaman
      body: Column(
        children: [
          const SizedBox(height: 10),

          //Ini bagian Tab Riwayat Transaksi
          Row(
            children: [
              //Ini bagian Tab Pembelian
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xff3164ff),
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Pembelian',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff3164ff),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              //Ini bagian Tab Rental
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const RiwayatRentalPage(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Rental',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Ini bagian Daftar Riwayat Pembelian
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _TransactionCard(
                  image: 'images/assets/misteripatung.jpg',
                  title: 'Misteri Patung Garam',
                  author: 'Ruwi Meita',
                  type: 'Pembelian',
                  price: 'Rp40.000',
                  date: '10 Jun 2026',
                ),
                _TransactionCard(
                  image: 'images/assets/atomichabits.jpg',
                  title: 'Atomic Habits',
                  author: 'James Clear',
                  type: 'Pembelian',
                  price: 'Rp34.000',
                  date: '8 Jun 2026',
                ),
                _TransactionCard(
                  image: 'images/assets/connectgroup.png',
                  title: 'Connect Group Training 1',
                  author: 'Connect Group Gereja GMS Church',
                  type: 'Pembelian',
                  price: 'Rp30.000',
                  date: '5 Jun 2026',
                ),
                _TransactionCard(
                  image: 'images/assets/injustice2.jpg',
                  title: 'Injustice 2',
                  author: 'Tom Taylor',
                  type: 'Pembelian',
                  price: 'Rp166.000',
                  date: '17 Mei 2026',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Ini bagian Kartu Riwayat Pembelian
class _TransactionCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String type;
  final String price;
  final String date;

  const _TransactionCard({
    required this.image,
    required this.title,
    required this.author,
    required this.type,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          //Ini bagian Gambar Buku
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              image,
              width: 72,
              height: 105,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 72,
                  height: 105,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.book),
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          //Ini bagian Informasi Buku
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Ini bagian Status Pembelian
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffc8ffbf),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Berhasil',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                //Ini bagian Judul Buku
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //Ini bagian Nama Penulis
                Text(
                  author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                //Ini bagian Jenis Transaksi dan Harga
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffe5d5ff),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                //Ini bagian Tanggal dan Invoice
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Colors.grey,
                      ),
                    ),

                    const Spacer(),

                    //Ini bagian Tombol Lihat Invoice
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InvoicePembelianPage(
                              imagePath: image,
                              title: title,
                              author: author,
                              category: 'Fiksi',
                              price: price,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Lihat invoice ›',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
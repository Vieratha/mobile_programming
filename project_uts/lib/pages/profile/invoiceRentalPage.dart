
import 'package:flutter/material.dart';

class InvoiceRentalPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;
  final String category;
  final String price;

  const InvoiceRentalPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.author,
    required this.category,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Invoice Rental',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      //Ini bagian Isi Invoice
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Ini bagian Header Invoice
              Row(
                children: [
                  Image.asset(
                    'images/assets/logo.png',
                    width: 48,
                    height: 48,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.menu_book,
                        size: 48,
                        color: Colors.blue,
                      );
                    },
                  ),

                  const SizedBox(width: 6),

                  const Text(
                    'Libra',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff17005c),
                    ),
                  ),

                  const Spacer(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'INVOICE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3164ff),
                        ),
                      ),
                      const Text(
                        '#INV18563729',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        '2 Juni 2026',
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Divider(),

              //Ini bagian Informasi Buku
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72,
                    height: 105,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 72,
                          height: 105,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.book,
                            size: 35,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          author,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              //Ini bagian Informasi Penyewa
              const Text(
                'Informasi Penyewa',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3164ff),
                ),
              ),

              const SizedBox(height: 8),

              const _RentalRow(
                title: 'Nama Lengkap',
                value: 'Ben',
              ),

              const _RentalRow(
                title: 'Email',
                value: 'ben12@gmail.com',
                underline: true,
              ),

              const _RentalRow(
                title: 'Nomor Telepon',
                value: '+62 819 3337 8485',
              ),

              const Divider(),

              //Ini bagian Detail Rental
              const Text(
                'Detail Rental',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3164ff),
                ),
              ),

              const SizedBox(height: 8),

              const _RentalRow(
                title: 'Durasi Rental',
                value: '7 Hari',
                boldValue: true,
              ),

              const _RentalRow(
                title: 'Tanggal Rental',
                value: '2 Juni 2026',
                boldValue: true,
              ),

              const _RentalRow(
                title: 'Tanggal Jatuh Tempo',
                value: '9 Juni 2026',
                boldValue: true,
              ),

              const Divider(),

              //Ini bagian Total Pembayaran
              Row(
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3164ff),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const _RentalRow(
                title: 'Metode Pembayaran',
                value: 'OVO',
              ),

              const _RentalRow(
                title: 'Status Pembayaran',
                value: 'Berhasil',
                status: true,
              ),

              const SizedBox(height: 10),

              //Ini bagian Pesan Berhasil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffe7efff),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff3164ff),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terima Kasih!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rental buku telah berhasil.',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'Buku dapat diakses di menu Koleksi Saya.',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Ini bagian Baris Informasi Rental
class _RentalRow extends StatelessWidget {
  final String title;
  final String value;
  final bool underline;
  final bool status;
  final bool boldValue;

  const _RentalRow({
    required this.title,
    required this.value,
    this.underline = false,
    this.status = false,
    this.boldValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),

          const Spacer(),

          if (status)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffc8ffbf),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 10,
                fontWeight: boldValue
                    ? FontWeight.bold
                    : FontWeight.normal,
                decoration: underline
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
        ],
      ),
    );
  }
}

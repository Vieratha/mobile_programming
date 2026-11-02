
import 'package:flutter/material.dart';

class InvoicePembelianPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;
  final String category;
  final String price;

  const InvoicePembelianPage({
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
          'Invoice Pembelian',
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
                        '#INV28562901',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        '10 Jun 2026',
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

              //Ini bagian Informasi Pembeli
              const Text(
                'Informasi Pembeli',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3164ff),
                ),
              ),

              const SizedBox(height: 8),

              _InvoiceRow(
                title: 'Nama Lengkap',
                value: 'Ben',
              ),

              _InvoiceRow(
                title: 'Email',
                value: 'ben12@gmail.com',
                underline: true,
              ),

              _InvoiceRow(
                title: 'Nomor Telepon',
                value: '+62 819 3337 8485',
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

              const _InvoiceRow(
                title: 'Metode Pembayaran',
                value: 'OVO',
              ),

              const _InvoiceRow(
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
                            'Pembelian buku telah berhasil.',
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

//Ini bagian Baris Informasi Invoice
class _InvoiceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool underline;
  final bool status;

  const _InvoiceRow({
    required this.title,
    required this.value,
    this.underline = false,
    this.status = false,
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

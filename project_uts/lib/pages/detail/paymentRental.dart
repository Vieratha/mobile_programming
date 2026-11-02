import 'package:flutter/material.dart';
import '../profile/riwayatRentalPage.dart';

class PembayaranRentalPage extends StatefulWidget {
  const PembayaranRentalPage({super.key});

  @override
  State<PembayaranRentalPage> createState() =>
      _PembayaranRentalPageState();
}

class _PembayaranRentalPageState
    extends State<PembayaranRentalPage> {

  String durasiRental = '7 Hari';
  String aksesBuku = 'online';

  String? metodePembayaran;

  DateTime? tanggalRental;

  @override
  Widget build(BuildContext context) {
    //Ini bagian untuk menentukan ukuran layar
    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;

    //Ini bagian untuk menentukan lebar halaman
    final double contentWidth =
    screenWidth > 950
        ? 950
        : screenWidth - 40;

    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        //Ini bagian Tombol Back
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(20),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        //Ini bagian Judul AppBar
        title: const Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Pembayaran Rental',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Lengkapi data untuk melanjutkan',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      //Ini bagian Isi Halaman
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 20 : 30,
                10,
                isMobile ? 20 : 30,
                30,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  //Ini bagian Informasi Buku
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      //Ini bagian Cover Buku
                      SizedBox(
                        width: isMobile ? 70 : 85,
                        height: isMobile ? 95 : 115,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(8),
                          child: Image.asset(
                            'images/assets/rumahlebah.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: isMobile ? 15 : 20,
                      ),

                      //Ini bagian Detail Buku
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Rumah Lebah',
                              style: TextStyle(
                                fontSize:
                                isMobile ? 18 : 21,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'Ruwi Meita',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'Dirilis 30 Sep 2019',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Divider(),

                  //Ini bagian Informasi Anda
                  const Text(
                    'Informasi Anda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //Ini bagian Input Nama
                  const Text(
                    'Nama Lengkap',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 5),

                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Input Email
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 5),

                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Input Nomor Telepon
                  const Text(
                    'Nomor Telepon',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 5),

                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Input Alamat
                  const Text(
                    'Alamat',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 5),

                  const TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      hintText:
                      'Masukkan alamat',
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Divider(),

                  //Ini bagian Informasi Buku
                  const Text(
                    'Informasi Buku',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //Ini bagian Judul Buku
                  pilihanBuku(
                    'Judul Buku',
                    'Rumah Lebah',
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Nama Penulis
                  pilihanBuku(
                    'Nama Penulis',
                    'Ruwi Meita',
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Kategori Buku
                  pilihanBuku(
                    'Kategori Buku',
                    'Fiksi',
                  ),

                  const SizedBox(height: 15),

                  const Divider(),

                  //Ini bagian Detail Rental
                  const Text(
                    'Detail Rental',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Durasi Rental
                  const Text(
                    'Durasi Rental',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 3),

                  //Ini bagian Pilihan Durasi Rental
                  Wrap(
                    children: [

                      Radio<String>(
                        value: '7 Hari',
                        groupValue: durasiRental,
                        onChanged: (value) {
                          setState(() {
                            durasiRental = value!;
                          });
                        },
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                          top: 12,
                        ),
                        child: Text(
                          '7 Hari',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),

                      Radio<String>(
                        value: '14 Hari',
                        groupValue: durasiRental,
                        onChanged: (value) {
                          setState(() {
                            durasiRental = value!;
                          });
                        },
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                          top: 12,
                        ),
                        child: Text(
                          '14 Hari',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),

                      Radio<String>(
                        value: '30 Hari',
                        groupValue: durasiRental,
                        onChanged: (value) {
                          setState(() {
                            durasiRental = value!;
                          });
                        },
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                          top: 12,
                        ),
                        child: Text(
                          '30 Hari',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  //Ini bagian Harga Rental
                  const Text(
                    'Harga Rental',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    width: double.infinity,
                    height: 42,
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius:
                      BorderRadius.circular(6),
                    ),
                    child: Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                        hargaRental(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3164ff),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Tanggal Rental
                  const Text(
                    'Tanggal Rental',
                    style: TextStyle(fontSize: 11),
                  ),

                  const SizedBox(height: 5),

                  //Ini bagian Pilihan Tanggal Rental
                  InkWell(
                    onTap: pilihTanggal,
                    borderRadius:
                    BorderRadius.circular(6),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius:
                        BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [

                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              tanggalRental == null
                                  ? 'Pilih tanggal rental'
                                  : formatTanggal(
                                tanggalRental!,
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                tanggalRental == null
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Divider(),

                  //Ini bagian Akses Buku
                  const Text(
                    'Akses Buku',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  //Ini bagian Pilihan Akses Buku
                  Row(
                    children: [

                      Radio<String>(
                        value: 'online',
                        groupValue: aksesBuku,
                        onChanged: (value) {
                          setState(() {
                            aksesBuku = value!;
                          });
                        },
                      ),

                      const Text(
                        'Baca Online',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(width: 20),

                      Radio<String>(
                        value: 'offline',
                        groupValue: aksesBuku,
                        onChanged: (value) {
                          setState(() {
                            aksesBuku = value!;
                          });
                        },
                      ),

                      const Text(
                        'Baca Offline',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Divider(),

                  //Ini bagian Metode Pembayaran
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //Ini bagian Pilihan QRIS
                  metodePembayaranItem(
                    'QRIS',
                    'Bayar menggunakan QRIS',
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Pilihan GoPay
                  metodePembayaranItem(
                    'GoPay',
                    'Bayar menggunakan GoPay',
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Pilihan Transfer Bank
                  metodePembayaranItem(
                    'Transfer Bank',
                    'BCA Virtual Account',
                  ),

                  const SizedBox(height: 8),

                  //Ini bagian Pilihan DANA
                  metodePembayaranItem(
                    'DANA',
                    'Bayar menggunakan DANA',
                  ),

                  const SizedBox(height: 15),

                  const Divider(),

                  //Ini bagian Ringkasan Pembayaran
                  Container(
                    padding:
                    const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                        Colors.grey.shade300,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        //Ini bagian Judul Ringkasan
                        const Text(
                          'Ringkasan Pembayaran',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        //Ini bagian Durasi
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            const Text(
                              'Durasi Rental',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                Colors.grey,
                              ),
                            ),
                            Text(
                              durasiRental,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        //Ini bagian Harga Rental
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            const Text(
                              'Harga Rental',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                Colors.grey,
                              ),
                            ),
                            Text(
                              hargaRental(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Divider(),

                        const SizedBox(height: 4),

                        //Ini bagian Total Pembayaran
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            const Text(
                              'Total Pembayaran',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                            Text(
                              hargaRental(),
                              style: const TextStyle(
                                fontSize: 17,
                                color:
                                Color(0xff3164ff),
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        //Ini bagian Tombol Lanjut
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: InkWell(
                            onTap: prosesRental,
                            borderRadius:
                            BorderRadius.circular(7),
                            child: Container(
                              decoration:
                              BoxDecoration(
                                color:
                                const Color(
                                  0xff3164ff,
                                ),
                                borderRadius:
                                BorderRadius
                                    .circular(7),
                              ),
                              child: const Center(
                                child: Text(
                                  'Lanjut',
                                  style: TextStyle(
                                    color:
                                    Colors.white,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Ini bagian Memilih Tanggal Rental
  Future<void> pilihTanggal() async {
    final DateTime sekarang = DateTime.now();

    final DateTime? tanggalDipilih =
    await showDatePicker(
      context: context,
      initialDate: tanggalRental ?? sekarang,
      firstDate: sekarang,
      lastDate: DateTime(
        sekarang.year + 1,
        sekarang.month,
        sekarang.day,
      ),
    );

    if (tanggalDipilih != null) {
      setState(() {
        tanggalRental = tanggalDipilih;
      });
    }
  }

  //Ini bagian Format Tanggal
  String formatTanggal(DateTime tanggal) {
    const List<String> namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${tanggal.day} '
        '${namaBulan[tanggal.month - 1]} '
        '${tanggal.year}';
  }

  //Ini bagian Menentukan Harga Rental
  String hargaRental() {
    if (durasiRental == '7 Hari') {
      return 'Rp 10.000';
    }

    if (durasiRental == '14 Hari') {
      return 'Rp 20.000';
    }

    return 'Rp 35.000';
  }

  //Ini bagian Proses Rental
  void prosesRental() {

    //Ini bagian Mengecek Tanggal Rental
    if (tanggalRental == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Tanggal Rental',
            ),
            content: const Text(
              'Silakan pilih tanggal rental terlebih dahulu.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    //Ini bagian Mengecek Metode Pembayaran
    if (metodePembayaran == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Metode Pembayaran',
            ),
            content: const Text(
              'Silakan pilih metode pembayaran terlebih dahulu.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    //Ini bagian Pop Up Rental Berhasil
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              //Ini bagian Icon Berhasil
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color:
                  const Color(0xffe7f8ed),
                  borderRadius:
                  BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 38,
                ),
              ),

              const SizedBox(height: 15),

              //Ini bagian Judul Berhasil
              const Text(
                'Rental Berhasil',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              //Ini bagian Keterangan Berhasil
              Text(
                'Rental Rumah Lebah berhasil dilakukan menggunakan $metodePembayaran.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );

    //Ini bagian Memindahkan ke Riwayat Rental
    Future.delayed(
      const Duration(seconds: 2),
          () {
        if (!mounted) {
          return;
        }

        Navigator.pop(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const RiwayatRentalPage(),
          ),
        );
      },
    );
  }

  //Ini bagian Pilihan Informasi Buku
  Widget pilihanBuku(
      String label,
      String isi,
      ) {
    return Row(
      children: [

        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: 38,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius:
              BorderRadius.circular(6),
            ),
            child: Row(
              children: [

                Expanded(
                  child: Text(
                    isi,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                    overflow:
                    TextOverflow.ellipsis,
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Ini bagian Item Metode Pembayaran
  Widget metodePembayaranItem(
      String nama,
      String keterangan,
      ) {
    final bool dipilih =
        metodePembayaran == nama;

    return InkWell(
      onTap: () {
        setState(() {
          metodePembayaran = nama;
        });
      },
      borderRadius:
      BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: dipilih
              ? const Color(0xfff1f5ff)
              : Colors.white,
          border: Border.all(
            color: dipilih
                ? const Color(0xff3164ff)
                : Colors.grey.shade300,
            width: dipilih ? 1.5 : 1,
          ),
          borderRadius:
          BorderRadius.circular(8),
        ),
        child: Row(
          children: [

            //Ini bagian Icon Pembayaran
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: dipilih
                    ? const Color(0xff3164ff)
                    : Colors.grey.shade100,
                borderRadius:
                BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                size: 19,
                color: dipilih
                    ? Colors.white
                    : Colors.grey,
              ),
            ),

            const SizedBox(width: 10),

            //Ini bagian Nama Metode
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    keterangan,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            //Ini bagian Tanda Pilihan
            Icon(
              dipilih
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              size: 20,
              color: dipilih
                  ? const Color(0xff3164ff)
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
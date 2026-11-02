import 'package:flutter/material.dart';
import 'paymentPembelian.dart';
import 'paymentRental.dart';

class DetailRumahLebah extends StatelessWidget {
  const DetailRumahLebah({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    double contentWidth = screenWidth;

    if (screenWidth > 1100) {
      contentWidth = 1100;
    }

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 22 : 30,
                  isMobile ? 20 : 25,
                  isMobile ? 22 : 30,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Ini bagian Tombol Back
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: isMobile ? 25 : 30,
                    ),

                    //Ini bagian Informasi Buku
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        //Ini bagian Cover Buku
                        SizedBox(
                          width: isMobile ? 89 : 120,
                          height: isMobile ? 129 : 174,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(6),
                            child: Image.asset(
                              'images/assets/rumahlebah.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: isMobile ? 18 : 22,
                        ),

                        //Ini bagian Judul dan Informasi Buku
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Rumah Lebah',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 22 : 28,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height: isMobile ? 8 : 10,
                              ),

                              Text(
                                'Ruwi Meita',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 14 : 16,
                                  color: Colors.black54,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height: isMobile ? 5 : 7,
                              ),

                              Text(
                                'Dirilis 30 Sep 2019',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 12 : 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: isMobile ? 15 : 20,
                    ),

                    //Ini bagian Rating dan Jumlah Halaman
                    Row(
                      children: [

                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '4,1 ⭐',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 18 : 20,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                '139 Ulasan',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 10 : 11,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: 1,
                          height: isMobile ? 35 : 45,
                          color: Colors.black12,
                        ),

                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '284',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 18 : 20,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                'Halaman',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 10 : 11,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: isMobile ? 14 : 18,
                    ),

                    //Ini bagian Tombol Pembelian dan Preview
                    Row(
                      children: [

                        //Ini bagian Tombol Preview
                        Expanded(
                          child: SizedBox(
                            height: isMobile ? 36 : 40,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xff005dff),
                                ),
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Preview',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 12 : 14,
                                  color:
                                  const Color(0xff005dff),
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: isMobile ? 12 : 15,
                        ),

                        //Ini bagian Tombol Beli
                        Expanded(
                          child: SizedBox(
                            height: isMobile ? 36 : 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const PembayaranPembelianPage(),
                                  ),
                                );
                              },
                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xff3164ff),
                                foregroundColor:
                                Colors.white,
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Beli Rp 53.625',
                                style: TextStyle(
                                  fontSize:
                                  isMobile ? 12 : 14,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    //Ini bagian Tombol Rental
                    SizedBox(
                      width: double.infinity,
                      height: isMobile ? 36 : 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const PembayaranRentalPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xff35ad78),
                          foregroundColor: Colors.white,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Rental',
                          style: TextStyle(
                            fontSize:
                            isMobile ? 12 : 14,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: isMobile ? 18 : 22,
                    ),

                    //Ini bagian Garis Pemisah
                    const Divider(
                      color: Colors.black12,
                      height: 1,
                    ),

                    SizedBox(
                      height: isMobile ? 12 : 16,
                    ),

                    //Ini bagian Tentang Buku
                    Text(
                      'Tentang Buku ini',
                      style: TextStyle(
                        fontSize:
                        isMobile ? 16 : 19,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: isMobile ? 7 : 9,
                    ),

                    //Ini bagian Deskripsi Buku
                    Text(
                      'Mala, gadis kecil berusia enam tahun yang terobsesi dengan ensiklopedia. Dia hanya membaca buku ensiklopedia dan selalu mengurutkan buku satu sampai buku terakhir dari sisi kiri ke sisi kanan. Dia juga tertarik dengan beruang. Di rumah, Mala hanya tinggal bersama orangtuanya, tetapi dia selalu membicarakan enam orang asing yang hidup bersama di dalam rumahnya. Dia selalu takut pada Satira, bersahabat dekat dengan Wilis, berbicara dengan Tante Ana yang suka berdandan, belajar bahasa Spanyol dengan Abuela, dan si Kembar yang hanya bisa mendengar, melihat dan mencatat. Siapakah sebenarnya enam orang asing yang selalu dibicarakan Mala? Rahasia apakah yang dimiliki oleh enam orang asing tersebut?',
                      style: TextStyle(
                        fontSize:
                        isMobile ? 10 : 13,
                        height: 1.35,
                      ),
                    ),

                    SizedBox(
                      height: isMobile ? 45 : 55,
                    ),

                    //Ini bagian Rating dan Ulasan
                    Text(
                      'Rating dan ulasan',
                      style: TextStyle(
                        fontSize:
                        isMobile ? 16 : 19,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: isMobile ? 14 : 18,
                    ),

                    //Ini bagian Isi Rating
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        //Ini bagian Nilai Rating
                        Column(
                          children: [
                            Text(
                              '4,1',
                              style: TextStyle(
                                fontSize:
                                isMobile ? 38 : 48,
                                fontWeight:
                                FontWeight.w400,
                              ),
                            ),

                            Text(
                              '★★★★☆',
                              style: TextStyle(
                                fontSize:
                                isMobile ? 13 : 16,
                                color:
                                const Color(0xffffc400),
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              '139 Ulasan',
                              style: TextStyle(
                                fontSize:
                                isMobile ? 7 : 9,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          width: isMobile ? 25 : 35,
                        ),

                        //Ini bagian Grafik Rating
                        Expanded(
                          child: Column(
                            children: [
                              _ratingBar('5', 0.70),
                              _ratingBar('4', 0.45),
                              _ratingBar('3', 0.08),
                              _ratingBar('2', 0.04),
                              _ratingBar('1', 0.10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Ini bagian Bar Rating
  Widget _ratingBar(
      String number,
      double value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [

          SizedBox(
            width: 12,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 4),

          Expanded(
            child: Stack(
              children: [

                //Ini bagian Background Bar
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                    BorderRadius.circular(5),
                  ),
                ),

                //Ini bagian Bar Rating Aktif
                FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xff293cff),
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
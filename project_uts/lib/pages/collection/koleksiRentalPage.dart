import 'package:flutter/material.dart';

class KoleksiRentalPage extends StatelessWidget {
  const KoleksiRentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Ini bagian untuk menentukan ukuran layar
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    //Ini bagian untuk menentukan padding halaman
    final double horizontalPadding = isMobile ? 10 : 24;

    //Ini bagian untuk menentukan lebar maksimum isi halaman
    final double contentWidth =
    screenWidth > 1100
        ? 1100
        : screenWidth - (horizontalPadding * 2);

    //Ini bagian untuk menentukan jarak antar buku
    final double bookSpacing = isMobile ? 7 : 14;

    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian Isi Halaman
      body: SafeArea(
        child: Column(
          children: [
            //Ini bagian Isi Buku Rental
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    15,
                    horizontalPadding,
                    20,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: contentWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Ini bagian Tombol Kembali
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          //Ini bagian Judul Buku Rental
                          const Text(
                            'Buku Rental',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 14),

                          //Ini bagian Daftar Buku Rental
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              //Ini bagian Buku Rental Pertama
                              Expanded(
                                child: _RentalBook(
                                  image:
                                  'images/assets/letthemtheory.jpg',
                                  title: 'The Let Them Theory',
                                  author: 'Mel Robbins',
                                  days: '3 Hari Lagi',
                                ),
                              ),

                              SizedBox(width: bookSpacing),

                              //Ini bagian Buku Rental Kedua
                              Expanded(
                                child: _RentalBook(
                                  image:
                                  'images/assets/cintabedausia.png',
                                  title: 'Cinta Beda Usia',
                                  author: 'Nev Nov',
                                  days: '6 Hari Lagi',
                                ),
                              ),

                              SizedBox(width: bookSpacing),

                              //Ini bagian Buku Rental Ketiga
                              Expanded(
                                child: _RentalBook(
                                  image:
                                  'images/assets/toloverelease.png',
                                  title: 'To Love, Release',
                                  author: 'Pipit Chie',
                                  days: '8 Hari Lagi',
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

            //Ini bagian Navbar bawah
            _buildBottomNavigation(isMobile),
          ],
        ),
      ),
    );
  }

  //Ini bagian Navbar bawah
  Widget _buildBottomNavigation(bool isMobile) {
    return Container(
      width: double.infinity,
      height: isMobile ? 68 : 76,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Ini bagian Beranda
            _BottomMenu(
              icon: 'images/assets/home_btn.png',
              label: 'Beranda',
              selected: false,
            ),

            //Ini bagian Eksplorasi
            _BottomMenu(
              icon: 'images/assets/search_btn.png',
              label: 'Eksplorasi',
              selected: false,
            ),

            //Ini bagian Koleksi
            _BottomMenu(
              icon: 'images/assets/book_btn_blue.png',
              label: 'Koleksi',
              selected: true,
            ),

            //Ini bagian Profil
            _BottomMenu(
              icon: 'images/assets/profile_btn.png',
              label: 'Profil',
              selected: false,
            ),
          ],
        ),
      ),
    );
  }
}


//Ini bagian Item Buku Rental
class _RentalBook extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String days;

  const _RentalBook({
    required this.image,
    required this.title,
    required this.author,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Ini bagian Cover Buku Rental
        AspectRatio(
          aspectRatio: 0.70,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        //Ini bagian Judul Buku Rental
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 2),

        //Ini bagian Nama Penulis Rental
        Text(
          author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 5),

        //Ini bagian Sisa Waktu Rental
        Container(
          height: 17,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffc4ffcb),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Ini bagian Icon Waktu Rental
              const Icon(
                Icons.calendar_month,
                size: 10,
                color: Color(0xff00aa74),
              ),

              const SizedBox(width: 3),

              //Ini bagian Teks Waktu Rental
              Text(
                days,
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xff00aa74),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


//Ini bagian Item Navbar
class _BottomMenu extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;

  const _BottomMenu({
    required this.icon,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: SizedBox(
        width: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Ini bagian Icon Navbar
            Image.asset(
              icon,
              width: 27,
              height: 27,
            ),

            const SizedBox(height: 2),

            //Ini bagian Label Navbar
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selected
                    ? const Color(0xff005dff)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
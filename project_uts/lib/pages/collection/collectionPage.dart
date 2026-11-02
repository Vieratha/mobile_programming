import 'package:flutter/material.dart';
import '../home/homePage.dart';
import '../exploration/explorationPage.dart';
import '../profile/profilePage.dart';
import 'koleksiDimilikiPage.dart';
import 'koleksiRentalPage.dart';

class KoleksiPage extends StatelessWidget {
  const KoleksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    //Ini bagian untuk menentukan padding halaman
    final double horizontalPadding = isMobile ? 13 : 24;

    //Ini bagian untuk menentukan lebar maksimum buku seperti HomePage
    final double contentWidth =
    screenWidth > 1100 ? 1100 : screenWidth - (horizontalPadding * 2);

    //Ini bagian untuk menentukan jarak antar buku
    final double bookSpacing = isMobile ? 7 : 14;

    //Ini bagian untuk menentukan lebar setiap buku
    final double cardWidth =
        (contentWidth - (bookSpacing * 3)) / 4;

    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian Isi Halaman
      body: SafeArea(
        child: Column(
          children: [
            //Ini bagian Isi Collection
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    14,
                    horizontalPadding,
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Ini bagian Judul Collection
                      const Text(
                        'Koleksi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 2),

                      //Ini bagian Subtitle Collection
                      const Text(
                        'Lihat dan Baca Koleksi Bukumu',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),

                      const SizedBox(height: 24),

                      //Ini bagian Buku Dimiliki
                      _buildBukuDimiliki(
                        context,
                        cardWidth,
                        bookSpacing,
                      ),

                      const SizedBox(height: 30),

                      //Ini bagian Rental Aktif
                      _buildRentalAktif(
                        context,
                        cardWidth,
                        bookSpacing,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Ini bagian Navbar bawah
            _buildBottomNavigation(
              context,
              isMobile,
            ),
          ],
        ),
      ),
    );
  }

  //Ini bagian Buku Dimiliki
  Widget _buildBukuDimiliki(
      BuildContext context,
      double cardWidth,
      double bookSpacing,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffedf6ff),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.fromLTRB(
        10,
        13,
        10,
        10,
      ),
      child: Column(
        children: [
          //Ini bagian Header Buku Dimiliki
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Ini bagian Icon Buku Dimiliki
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xffdbeaff),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.library_books,
                  color: Color(0xff3164ff),
                  size: 22,
                ),
              ),

              const SizedBox(width: 15),

              //Ini bagian Judul dan Deskripsi Buku Dimiliki
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buku Dimiliki',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2144a4),
                      ),
                    ),

                    SizedBox(height: 1),

                    Text(
                      'Koleksi buku yang telah kamu beli dan miliki\nsecara permanen.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //Ini bagian Card Buku Dimiliki
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              10,
              11,
              10,
              9,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                //Ini bagian Daftar Buku Dimiliki
                //Ini bagian Daftar Buku Dimiliki
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Ini bagian Buku Pertama
                    Expanded(
                      child: _BookItem(
                        image:
                        'images/assets/misteripatung.jpg',
                        title: 'Misteri Patung Garam',
                        author: 'Ruwi Meita',
                      ),
                    ),

                    SizedBox(width: bookSpacing),

                    //Ini bagian Buku Kedua
                    Expanded(
                      child: _BookItem(
                        image:
                        'images/assets/atomichabits.jpg',
                        title: 'Atomic Habits',
                        author: 'James Clear',
                      ),
                    ),

                    SizedBox(width: bookSpacing),

                    //Ini bagian Buku Ketiga
                    Expanded(
                      child: _BookItem(
                        image:
                        'images/assets/connectgroup.png',
                        title: 'Connect Group',
                        author: 'GMS Church',
                      ),
                    ),

                    SizedBox(width: bookSpacing),

                    //Ini bagian Buku Keempat
                    Expanded(
                      child: _BookItem(
                        image:
                        'images/assets/injustice2.jpg',
                        title: 'Injustice 2',
                        author: 'Tom Taylor',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                //Ini bagian Garis Pembatas Buku Dimiliki
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),

                const SizedBox(height: 7),

                //Ini bagian Total Buku Dimiliki
                Row(
                  children: [
                    const Icon(
                      Icons.library_books,
                      color: Color(0xff005dff),
                      size: 22,
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        'Total 4 Buku',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff005dff),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Ini bagian Tombol Panah Buku Dimiliki
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const KoleksiDimilikiPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xff3164ff),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 20,
                          ),
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

  //Ini bagian Rental Aktif
  Widget _buildRentalAktif(
      BuildContext context,
      double cardWidth,
      double bookSpacing,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xfff5fef0),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.fromLTRB(
        10,
        13,
        10,
        10,
      ),
      child: Column(
        children: [
          //Ini bagian Header Rental Aktif
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Ini bagian Icon Rental Aktif
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xffdfffd8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Color(0xff22916e),
                  size: 22,
                ),
              ),

              const SizedBox(width: 15),

              //Ini bagian Judul dan Deskripsi Rental Aktif
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rental Aktif',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff22916e),
                      ),
                    ),

                    SizedBox(height: 1),

                    Text(
                      'Buku yang sedang kamu sewa.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //Ini bagian Card Rental Aktif
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              10,
              11,
              10,
              9,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                //Ini bagian Daftar Buku Rental
                //Ini bagian Daftar Buku Rental
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Ini bagian Buku Rental Pertama
                    Expanded(
                      child: _RentalBookItem(
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
                      child: _RentalBookItem(
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
                      child: _RentalBookItem(
                        image:
                        'images/assets/toloverelease.png',
                        title: 'To Love, Release',
                        author: 'Pipit Chie',
                        days: '8 Hari Lagi',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                //Ini bagian Garis Pembatas Rental
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),

                const SizedBox(height: 7),

                //Ini bagian Total Buku Rental
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color(0xff00aa74),
                      size: 23,
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        'Total 3 Buku Rental',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff00aa74),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Ini bagian Tombol Panah Rental
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const KoleksiRentalPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xff43ad56),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 20,
                          ),
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

  //Ini bagian Navbar bawah
  Widget _buildBottomNavigation(
      BuildContext context,
      bool isMobile,
      ) {
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
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),

            //Ini bagian Eksplorasi
            _BottomMenu(
              icon: 'images/assets/search_btn.png',
              label: 'Eksplorasi',
              selected: false,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const ExplorationPage(),
                  ),
                );
              },
            ),

            //Ini bagian Koleksi
            _BottomMenu(
              icon: 'images/assets/book_btn_blue.png',
              label: 'Koleksi',
              selected: true,
              onTap: () {},
            ),

            //Ini bagian Profil
            _BottomMenu(
              icon: 'images/assets/profile_btn.png',
              label: 'Profil',
              selected: false,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Ini bagian Item Buku Dimiliki
class _BookItem extends StatelessWidget {
  final String image;
  final String title;
  final String author;

  const _BookItem({
    required this.image,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Ini bagian Cover Buku
        AspectRatio(
          aspectRatio: 0.70,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),

        //Ini bagian Judul Buku
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 1),

        //Ini bagian Nama Penulis
        Text(
          author,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

//Ini bagian Item Buku Rental
class _RentalBookItem extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String days;

  const _RentalBookItem({
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
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),

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

        const SizedBox(height: 1),

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
              const Icon(
                Icons.calendar_month,
                size: 10,
                color: Color(0xff00aa74),
              ),

              const SizedBox(width: 3),

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
  final VoidCallback onTap;

  const _BottomMenu({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
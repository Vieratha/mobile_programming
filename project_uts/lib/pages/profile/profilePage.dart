import 'package:flutter/material.dart';
import '../home/homePage.dart';
import '../exploration/explorationPage.dart';
import 'informasiAkunPage.dart';
import 'keamananPage.dart';
import 'riwayatPembelianPage.dart';
import 'pusatBantuanPage.dart';
import '../collection/collectionPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedMenu = 3;

  String nama = 'Pir';
  String email = 'vietha@gmail.com';
  String nomorHandphone = '';

  //Ini bagian Membuka Informasi Akun
  void bukaInformasiAkun() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformasiAkunPage(
          namaAwal: nama,
          emailAwal: email,
          nomorHandphoneAwal: nomorHandphone,
        ),
      ),
    ).then((hasil) {
      if (hasil != null) {
        setState(() {
          nama = hasil['nama'];
          email = hasil['email'];
          nomorHandphone = hasil['nomorHandphone'];
        });
      }
    });
  }

  //Ini bagian Navbar bawah
  Widget _buildBottomNavigation() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

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
              icon: selectedMenu == 0
                  ? 'images/assets/home_btn_blue.png'
                  : 'images/assets/home_btn.png',
              label: 'Beranda',
              selected: selectedMenu == 0,
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
              icon: selectedMenu == 1
                  ? 'images/assets/search_btn_blue.png'
                  : 'images/assets/search_btn.png',
              label: 'Eksplorasi',
              selected: selectedMenu == 1,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExplorationPage(),
                  ),
                );
              },
            ),

            //Ini bagian Koleksi
            _BottomMenu(
              icon: selectedMenu == 2
                  ? 'images/assets/book_btn_blue.png'
                  : 'images/assets/book_btn.png',
              label: 'Koleksi',
              selected: selectedMenu == 2,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KoleksiPage(),
                  ),
                );
              },
            ),

            //Ini bagian Profil
            _BottomMenu(
              icon: selectedMenu == 3
                  ? 'images/assets/profile_btn_blue.png'
                  : 'images/assets/profile_btn.png',
              label: 'Profil',
              selected: selectedMenu == 3,
              onTap: () {
                setState(() {
                  selectedMenu = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian Isi Halaman
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                //Ini bagian Judul Profil
                const Text(
                  'Profil Saya',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff17005c),
                  ),
                ),

                const SizedBox(height: 18),

                //Ini bagian Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f9ff),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          //Ini bagian Foto Profil
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'images/assets/uriel.png',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        size: 38,
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                              ),

                              //Ini bagian Tombol Kamera
                              Positioned(
                                right: -3,
                                bottom: -3,
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff4d7cff),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 12),

                          //Ini bagian Informasi Profil
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nama,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                email,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      //Ini bagian Statistik Profil
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.menu_book_outlined,
                                  color: Color(0xff4d7cff),
                                  size: 30,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  '4',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Buku Dimiliki',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 55,
                            width: 1,
                            color: Colors.black12,
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Color(0xff4d7cff),
                                  size: 30,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rental Aktif',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                //Ini bagian Akun dan Aktivitas
                const Text(
                  'Akun & Aktivitas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                //Ini bagian Menu Akun
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    children: [
                      //Ini bagian Informasi Akun
                      _ProfileMenu(
                        icon: Icons.person_outline,
                        title: 'Informasi Akun',
                        subtitle: 'Edit profil, email, menambah nomor',
                        onTap: bukaInformasiAkun,
                      ),

                      //Ini bagian Keamanan
                      _ProfileMenu(
                        icon: Icons.lock_outline,
                        title: 'Keamanan',
                        subtitle: 'Ubah kata sandi akun',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KeamananPage(),
                            ),
                          );
                        },
                      ),

                      //Ini bagian Riwayat Transaksi
                      _ProfileMenu(
                        icon: Icons.receipt_long_outlined,
                        title: 'Riwayat Transaksi',
                        subtitle: 'Lihat riwayat pembelian dan rental',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const RiwayatPembelianPage(),
                            ),
                          );
                        },
                      ),

                      //Ini bagian Pusat Bantuan
                      _ProfileMenu(
                        icon: Icons.help_outline,
                        title: 'Pusat Bantuan',
                        subtitle: 'FAQ dan bantuan',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const PusatBantuanPage(),
                            ),
                          );
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                //Ini bagian Tombol Keluar
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                            (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'Keluar Dari Akun',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                      backgroundColor: const Color(0xffffeeee),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      //Ini bagian Navbar bawah
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}


//Ini bagian Menu Profil
class _ProfileMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLast;

  const _ProfileMenu({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(
            bottom: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: [
            //Ini bagian Icon Menu
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffeaf5ff),
              ),
              child: Icon(
                icon,
                color: const Color(0xff4d8cff),
                size: 23,
              ),
            ),

            const SizedBox(width: 10),

            //Ini bagian Informasi Menu
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
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
            Image.asset(
              icon,
              width: 27,
              height: 27,
            ),

            const SizedBox(height: 2),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
                color:
                selected ? const Color(0xff005dff) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
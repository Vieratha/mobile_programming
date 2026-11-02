import 'package:flutter/material.dart';
import '../profile/profilePage.dart';
import '../exploration/explorationPage.dart';
import '../collection/collectionPage.dart';
import '../collection/koleksiDimilikiPage.dart';
import '../collection/koleksiRentalPage.dart';
import '../detail/detailRumahLebah.dart';
import '../detail/bacaNovelPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedMenu = 0;
  String? selectedCategory;
  String? selectedCollection;

  final List<Map<String, String>> kategori = [
    {
      'nama': 'Fiksi',
      'gambar': 'images/assets/book_cat.png',
    },
    {
      'nama': 'Non-Fiksi',
      'gambar': 'images/assets/leather_cat.png',
    },
    {
      'nama': 'Bisnis',
      'gambar': 'images/assets/business_cat.png',
    },
    {
      'nama': 'Teknologi',
      'gambar': 'images/assets/tech_cat.png',
    },
    {
      'nama': 'Pendidikan',
      'gambar': 'images/assets/pendidikan_cat.png',
    },
  ];

  final List<Map<String, String>> bukuPopuler = [
    {
      'judul': 'Rumah Lebah',
      'penulis': 'Ruwi Meita',
      'gambar': 'images/assets/rumahlebah.jpg',
    },
    {
      'judul': 'Atomic Habits',
      'penulis': 'James Clear',
      'gambar': 'images/assets/atomichabits.jpg',
    },
    {
      'judul': 'Connect Group',
      'penulis': 'GMS Church',
      'gambar': 'images/assets/connectgroup.png',
    },
    {
      'judul': 'Twelve Months',
      'penulis': 'Jim Butcher',
      'gambar': 'images/assets/twelvemonths.jpg',
    },
  ];

  final List<Map<String, String>> rekomendasi = [
    {
      'judul': 'Forensic Psychology',
      'penulis': 'Connor Whiteley',
      'gambar': 'images/assets/forensicpsychology.jpeg',
    },
    {
      'judul': 'Time Management',
      'penulis': 'Sudhir Dixit',
      'gambar': 'images/assets/timemanagement.webp',
    },
    {
      'judul': 'Kapan Jatuh Cinta',
      'penulis': 'Hanif Mahaldi',
      'gambar': 'images/assets/kapanjatuhcinta.jpeg',
    },
    {
      'judul': 'Kurir Jiwa',
      'penulis': 'Hanif Mahaldi',
      'gambar': 'images/assets/kurirjiwa.jpg',
    },
  ];

  final List<Map<String, String>> bisnis = [
    {
      'judul': '108 Tanya Jawab',
      'penulis': 'Joko Salim, S.Kom.',
      'gambar': 'images/assets/108jawaban.jpeg',
    },
    {
      'judul': 'Kebelet Kaya',
      'penulis': 'Mardigu WP',
      'gambar': 'images/assets/kebeletkaya.jpeg',
    },
    {
      'judul': 'Kapan Jatuh Cinta',
      'penulis': 'Hanif Mahaldi',
      'gambar': 'images/assets/kapanjatuhcinta.jpeg',
    },
    {
      'judul': 'Jangan Belanja',
      'penulis': 'Benny Lo',
      'gambar': 'images/assets/atomichabits.jpg',
    },
  ];

  final List<Map<String, String>> sastra = [
    {
      'judul': 'Pulang',
      'penulis': 'Tere Liye',
      'gambar': 'images/assets/pulang.jpeg',
    },
    {
      'judul': 'Negeri Para Bedebah',
      'penulis': 'Tere Liye',
      'gambar': 'images/assets/negeriparabedebah.jpg',
    },
    {
      'judul': 'It Takes Two',
      'penulis': 'Niken Darcy',
      'gambar': 'images/assets/ittakes.jpg',
    },
    {
      'judul': 'Twelve Months',
      'penulis': 'Jim Butcher',
      'gambar': 'images/assets/twelvemonths.jpg',
    },
  ];

  final List<Map<String, String>> sepertiInjustice = [
    {
      'judul': 'Injustice: Gods',
      'penulis': 'Brian Buccellato',
      'gambar': 'images/assets/injustice.jpeg',
    },
    {
      'judul': 'Nightwing Vol.',
      'penulis': 'Tom Taylor',
      'gambar': 'images/assets/nightwing.jpg',
    },
    {
      'judul': 'Injustice 2',
      'penulis': 'Tom Taylor',
      'gambar': 'images/assets/injustice2.jpg',
    },
    {
      'judul': 'Guardians',
      'penulis': 'Brian Michael',
      'gambar': 'images/assets/guardians.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet =
        screenWidth >= 600 && screenWidth < 1000;
    double contentWidth = screenWidth;

    if (screenWidth > 1100) {
      contentWidth = 1100;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: isMobile ? 10 : 15,
                ),
                child: Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          _buildHeader(isMobile),

                          const SizedBox(height: 20),
                          _buildGreeting(),

                          const SizedBox(height: 14),
                          _buildContinueCard(isMobile),

                          const SizedBox(height: 20),
                          _buildCategorySection(
                            isMobile,
                            isTablet,
                          ),

                          const SizedBox(height: 16),
                          _buildRentalAndCollection(
                            isMobile,
                          ),

                          const SizedBox(height: 25),
                          _BookSection(
                            title: '🔥 Buku Populer',
                            books: bukuPopuler,
                            showSeeAll: true,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),

                          const SizedBox(height: 25),
                          _BookSection(
                            title: 'Rekomendasi Untuk Kamu',
                            books: rekomendasi,
                            showSeeAll: true,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),

                          const SizedBox(height: 25),
                          _BookSection(
                            title: 'Bisnis & Investasi',
                            books: bisnis,
                            showSeeAll: true,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),

                          const SizedBox(height: 25),
                          _BookSection(
                            title: 'Sastra & Fiksi',
                            books: sastra,
                            showSeeAll: true,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),

                          const SizedBox(height: 25),
                          _BookSection(
                            title: 'Lainnya seperti Injustice 2',
                            books: sepertiInjustice,
                            showSeeAll: true,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildBottomNavigation(isMobile),
          ],
        ),
      ),
    );
  }

 //Ini bagian Header dari Libra Mobile
  Widget _buildHeader(bool isMobile) {
    return Row(
      children: [
        Image.asset(
          'images/assets/logo.png',
          width: isMobile ? 44 : 48,
          height: isMobile ? 44 : 48,
        ),

        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Libra',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Color(0xff0d004e),
                height: 0.9,
              ),
            ),
            Text(
              'mobile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff005eff),
                letterSpacing: 3,
              ),
            ),
          ],
        ),

        const Spacer(),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Notifikasi',
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    'Belum ada notifikasi baru.',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Color(0xff005dff),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset(
            'images/assets/Lonceng.png',
            width: isMobile ? 35 : 40,
            height: isMobile ? 35 : 40,
          ),
        ),
      ],
    );
  }

  //Ini bagian Greetings untuk user
  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, Pir!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 3),
        Text(
          'Temukan buku terbaik untukmu hari ini.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  //Ini bagian "Continue Reading", dengan buku terakhir kali dibaca
  Widget _buildContinueCard(bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xfff3f3f3),
            Color(0xff5191ff),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(
        isMobile ? 12 : 15,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          //Ini bagian Judul Continue Reading
          Row(
            children: [
              const Icon(
                Icons.menu_book,
                color: Color(0xff2144a4),
                size: 21,
              ),

              const SizedBox(width: 7),

              const Expanded(
                child: Text(
                  'Lanjutkan Membaca',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2144a4),
                  ),
                ),
              ),

              //Ini bagian Tombol Lihat Semua
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Menampilkan semua buku yang sedang dibaca',
                      ),
                    ),
                  );
                },
                borderRadius:
                BorderRadius.circular(5),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    'Lihat Semua →',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2144a4),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          //Ini bagian Buku yang Sedang Dibaca
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [

              //Ini bagian Cover Buku
              ClipRRect(
                borderRadius:
                BorderRadius.circular(6),
                child: Image.asset(
                  'images/assets/WhetherYouCallMeADragon.png',
                  width: isMobile ? 74 : 89,
                  height: isMobile ? 108 : 129,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(
                width: isMobile ? 12 : 15,
              ),

              //Ini bagian Informasi Buku
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Whether You Call Me a Dragon or Not, Im Going to Sleep',
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'Aseutareuteseu',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 12),

                    //Ini bagian Progress Membaca
                    const Text(
                      '68% Selesai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                        color: Color(0xff005dff),
                      ),
                    ),

                    const SizedBox(height: 7),

                    //Ini bagian Progress Bar
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child:
                      FractionallySizedBox(
                        alignment:
                        Alignment.centerLeft,
                        widthFactor: 0.68,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(
                              0xff005dff,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    //Ini bagian Tombol Lanjutkan
                    SizedBox(
                      width: isMobile ? 115 : 130,
                      height: 32,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const BacaNovelPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 16,
                        ),
                        label: const Text(
                          'Lanjutkan',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(
                            0xff005dff,
                          ),
                          foregroundColor:
                          Colors.white,
                          padding: EdgeInsets.zero,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              7,
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
        ],
      ),
    );
  }

  //Ini bagian "Category" atau genre
  Widget _buildCategorySection(
      bool isMobile,
      bool isTablet,
      ) {
    final screenWidth =
        MediaQuery.of(context).size.width;
    double categoryWidth;

    if (isMobile) {
      categoryWidth =
          (screenWidth - 24 - 40) / 5;
      if (categoryWidth < 70) {
        categoryWidth = 70;
      }
      if (categoryWidth > 82) {
        categoryWidth = 82;
      }
    } else if (isTablet) {
      categoryWidth =
          (screenWidth - 32 - 40) / 5;
      if (categoryWidth < 90) {
        categoryWidth = 90;
      }
      if (categoryWidth > 110) {
        categoryWidth = 110;
      }
    } else {
      categoryWidth =
          (screenWidth - 32 - 40) / 5;
      if (categoryWidth < 110) {
        categoryWidth = 110;
      }
      if (categoryWidth > 150) {
        categoryWidth = 150;
      }
    }

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 9),
        Row(
          children: [
            for (int i = 0;
            i < kategori.length;
            i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: i == kategori.length - 1
                        ? 0
                        : 10,
                  ),
                  child: _CategoryItem(
                    nama: kategori[i]['nama']!,
                    gambar:
                    kategori[i]['gambar']!,
                    width: categoryWidth,
                    selected:
                    selectedCategory ==
                        kategori[i]['nama'],
                    onTap: () {
                      setState(() {
                        selectedCategory =
                        kategori[i]['nama'];
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  //Ini bagian Rental dan Koleksi
  Widget _buildRentalAndCollection(
      bool isMobile,
      ) {
    if (isMobile) {
      return const Column(
        children: [
          _RentalCard(),
          SizedBox(height: 12),
          _CollectionCard(),
        ],
      );
    }

    return const Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _RentalCard(),
        ),

        SizedBox(width: 12),
        Expanded(
          child: _CollectionCard(),
        ),
      ],
    );
  }

  //Ini bagian navbar bawah
  Widget _buildBottomNavigation(
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
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            //Ini Home
            _BottomMenu(
              icon: selectedMenu == 0
                  ? 'images/assets/home_btn_blue.png'
                  : 'images/assets/home_btn.png',
              label: 'Beranda',
              selected: selectedMenu == 0,
              onTap: () {
                setState(() {
                  selectedMenu = 0;
                });
              },
            ),
            //Ini Search/Exploration
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
            //Ini Collection
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
            //Ini Profile
            _BottomMenu(
              icon: selectedMenu == 3
                  ? 'images/assets/profile_btn_blue.png'
                  : 'images/assets/profile_btn.png',
              label: 'Profil',
              selected: selectedMenu == 3,
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

//Ini bagian kategori item
class _CategoryItem extends StatelessWidget {
  final String nama;
  final String gambar;
  final double width;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.nama,
    required this.gambar,
    required this.width,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      //Ini bagian agar cursor berubah menjadi cursor klik
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
        width: width,
        height: 82,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffdceaff)
              : const Color(0xfff5f8ff),
          borderRadius:
          BorderRadius.circular(9),
          border: Border.all(
            color: selected
                ? const Color(0xff005dff)
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Image.asset(
              gambar,
              width: 38,
              height: 38,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 4),
            Text(
              nama,
              maxLines: 1,
              overflow:
              TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
          ),
      ),
    );
  }
}

//Ini bagian dari Rental Aktif yang berisi tentang rental yang ada dan masih terdapat sisa waktu
class _RentalCard
    extends StatelessWidget {
  const _RentalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding:
      const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color:
        const Color(0xffeffff6),
        borderRadius:
        BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Rental Aktif',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Color(0xff2c594b),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Menampilkan semua rental aktif',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Lihat Semua →',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                    Color(0xff2c594b),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 1),
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(6),
                  child: Image.asset(
                    'images/assets/letthemtheory.jpg',
                    width: 78,
                    height: 115,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 115,
                    padding:
                    const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                      const Color(0xfff5fef0),
                      borderRadius:
                      BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'The Let Them Theory',
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const Text(
                          'Mel Robbins',
                          style: TextStyle(
                            fontSize: 11,
                            color:
                            Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 5),
                        const Text(
                          '⏱  5 Hari',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const Spacer(),
                        SizedBox(
                          width:
                          double.infinity,
                          height: 29,
                          child:
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger
                                  .of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Membuka The Let Them Theory',
                                  ),
                                ),
                              );
                            },
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              const Color(
                                0xff5e9d82,
                              ),
                              foregroundColor:
                              Colors.white,
                              padding:
                              EdgeInsets.zero,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  7,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Baca Sekarang',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

//Ini bagian "Koleksi Saya" yang berisi bagian "Buku Dimiliki" dan "Rental Aktif"
class _CollectionCard
    extends StatelessWidget {
  const _CollectionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding:
      const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color:
        const Color(0xfff1e4ff),
        borderRadius:
        BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            'Koleksi Saya',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
              color:
              Color(0xff4f3886),
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                _CollectionButton(
                  icon:
                  'images/assets/books_collection.png',
                  label: 'Buku Dimiliki',
                ),

                const SizedBox(height: 8),
                _CollectionButton(
                  icon:
                  'images/assets/callender_collection.png',
                  label: 'Rental Aktif',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Ini bagian button untuk koleksi ketika diinteraksi
class _CollectionButton extends StatelessWidget {
  final String icon;
  final String label;

  const _CollectionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (label == 'Buku Dimiliki') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const KoleksiDimilikiPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const KoleksiRentalPage(),
              ),
            );
          }
        },

        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: const Color(0xffdfd0f2),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                icon,
                width: 32,
                height: 32,
              ),

              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4f3886),
                  ),
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Color(0xff4f3886),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Ini bagian dari section-section buku
class _BookSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> books;
  final bool showSeeAll;
  final bool isMobile;
  final bool isTablet;

  const _BookSection({
    required this.title,
    required this.books,
    required this.showSeeAll,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;
    final availableWidth =
    screenWidth > 1100
        ? 1100 - 32
        : screenWidth -
        (isMobile ? 24 : 32);

    double gap;
    if (isMobile) {
      gap = 8;
    } else if (isTablet) {
      gap = 12;
    } else {
      gap = 24;
    }

    final cardWidth =
        (availableWidth - (gap * 3)) / 4;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            if (showSeeAll)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Menampilkan semua buku di bagian $title',
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'Lihat Semua →',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Color(0xff68a0df),
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 7),
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            for (int i = 0;
            i < books.length;
            i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: i == 0
                        ? 0
                        : gap / 2,
                    right: i ==
                        books.length - 1
                        ? 0
                        : gap / 2,
                  ),
                  child: _BookCard(
                    judul:
                    books[i]['judul']!,
                    penulis:
                    books[i]['penulis']!,
                    gambar:
                    books[i]['gambar']!,
                    width: cardWidth,
                    isMobile: isMobile,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

//Ini bagian book card yg membungkus buku
class _BookCard
    extends StatelessWidget {
  final String judul;
  final String penulis;
  final String gambar;
  final double width;
  final bool isMobile;

  const _BookCard({
    required this.judul,
    required this.penulis,
    required this.gambar,
    required this.width,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight =
        width * 1.43;

    return MouseRegion(
      //Ini bagian agar cursor tetap normal
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () {
          if (judul == 'Rumah Lebah') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const DetailRumahLebah(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$judul dipilih'),
              ),
            );
          }
        },

        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              //Ini bagian Cover Buku
              Container(
                width: width,
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(7),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(7),
                  child: Image.asset(
                    gambar,
                    width: width,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              //Ini bagian Judul Buku
              Text(
                judul,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:
                  isMobile ? 9 : 12,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 1),

              //Ini bagian Nama Penulis
              Text(
                penulis,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:
                  isMobile ? 8 : 10,
                  color:
                  Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Ini bagian tombol menu
class _BottomMenu
    extends StatelessWidget {
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
          mainAxisAlignment:
          MainAxisAlignment.center,
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
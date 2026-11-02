import 'package:flutter/material.dart';
import '../home/homePage.dart';
import '../collection/collectionPage.dart';
import '../profile/profilePage.dart';

class ExplorationPage extends StatefulWidget {
  const ExplorationPage({super.key});

  @override
  State<ExplorationPage> createState() => _ExplorationPageState();
}

class _ExplorationPageState extends State<ExplorationPage> {
  //Untuk mengetik pada search bar
  final TextEditingController searchController =
  TextEditingController();
  //Untuk mengetahui apakah search bar sedang aktif
  bool searchAktif = false;
  //Ini bagian daftar buku yang digunakan pada halaman eksplorasi
  final List<Map<String, String>> daftarBuku = [
    {
      'judul': 'Bumi',
      'penulis': 'Tere Liye',
      'kategori': 'Fiksi',
      'gambar': 'images/assets/Bumi.jpg',
    },
    {
      'judul': 'Laskar Pelangi',
      'penulis': 'Andrea Hirata',
      'kategori': 'Fiksi',
      'gambar': 'images/assets/LaskarPelangi.jpg',
    },
    {
      'judul': 'Negeri 5 Menara',
      'penulis': 'Ahmad Fuadi',
      'kategori': 'Fiksi',
      'gambar': 'images/assets/Negeri5Menara.jpg',
    },
    {
      'judul': 'Atomic Habits',
      'penulis': 'James Clear',
      'kategori': 'Pengembangan Diri',
      'gambar': 'images/assets/AtomicHabits.jpg',
    },
    {
      'judul': 'The Psychology of Money',
      'penulis': 'Morgan Housel',
      'kategori': 'Keuangan',
      'gambar': 'images/assets/Psychology.jpg',
    },
    {
      'judul': 'Injustice 2',
      'penulis': 'Tom Taylor',
      'kategori': 'Komik',
      'gambar': 'images/assets/Injustice2.jpg',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  //Ini bagian untuk mengaktifkan search
  void mulaiSearch() {
    setState(() {
      searchAktif = true;
    });
  }

  //Ini bagian untuk menutup search
  void tutupSearch() {
    setState(() {
      searchAktif = false;
      searchController.clear();
    });
  }

  //Ini bagian untuk mencari buku berdasarkan judul, penulis, atau kategori
  List<Map<String, String>> hasilPencarian() {
    String keyword = searchController.text.toLowerCase();
    if (keyword.isEmpty) {
      return [];
    }

    return daftarBuku.where((buku) {
      String judul = buku['judul']!.toLowerCase();
      String penulis = buku['penulis']!.toLowerCase();
      String kategori = buku['kategori']!.toLowerCase();

      return judul.contains(keyword) ||
          penulis.contains(keyword) ||
          kategori.contains(keyword);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //Ini bagian Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                10,
              ),
              child: Row(
                children: [
                  //Ini bagian tombol Back
                  InkWell(
                    onTap: () {
                      if (searchAktif) {
                        tutupSearch();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  //Ini bagian Search Field
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 23,
                          ),

                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              autofocus: searchAktif,
                              readOnly: !searchAktif,
                              mouseCursor:
                              SystemMouseCursors.text,
                              onTap: mulaiSearch,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: const InputDecoration(
                                hintText: 'Cari buku...',
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),

                          //Ini bagian tombol untuk menghapus pencarian
                          if (searchAktif &&
                              searchController.text.isNotEmpty)
                            InkWell(
                              onTap: () {
                                searchController.clear();
                                setState(() {});
                              },
                              splashColor: Colors.transparent,
                              highlightColor:
                              Colors.transparent,
                              hoverColor:
                              Colors.transparent,
                              child: const Padding(
                                padding: EdgeInsets.all(3),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 20,
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

            //Ini bagian isi halaman
            Expanded(
              child: searchAktif
                  ? tampilanSearch()
                  : tampilanEksplorasi(),
            ),
          ],
        ),
      ),
      //Ini bagian Navbar bawah
      bottomNavigationBar:
      _buildBottomNavigation(isMobile),
    );
  }

  //Ini bagian tampilan utama Eksplorasi
  Widget tampilanEksplorasi() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        20,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          //Ini bagian Mungkin Anda Suka
          const Text(
            'Mungkin Anda Suka',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),
          //Ini bagian daftar buku rekomendasi
          SizedBox(
            height: 285,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                return kartuBuku(
                  daftarBuku[index],
                );
              },
            ),
          ),

          const SizedBox(height: 30),
          //Ini bagian Kategori
          const Text(
            'Kategori',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              kategoriButton('Fiksi'),
              kategoriButton('Komik'),
              kategoriButton('Romansa'),
              kategoriButton('Pengembangan Diri'),
              kategoriButton('Keuangan'),
            ],
          ),

          const SizedBox(height: 30),
          //Ini bagian Buku Pilihan
          const Text(
            'Buku Pilihan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),
          bukuListTile(daftarBuku[0]),
          bukuListTile(daftarBuku[1]),
          bukuListTile(daftarBuku[2]),
        ],
      ),
    );
  }

  //Ini bagian tampilan saat Search aktif
  Widget tampilanSearch() {
    String keyword = searchController.text;
    //Ini bagian Pencarian Populer saat belum mengetik
    if (keyword.isEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Text(
              'Pencarian Populer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            pencarianPopuler('Tere Liye'),
            pencarianPopuler('Fiksi'),
            pencarianPopuler('Tom Taylor'),
            pencarianPopuler('Romansa'),

            const SizedBox(height: 30),
            //Ini bagian Mungkin Anda Suka saat Search
            const Text(
              'Mungkin Anda Suka',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),
            bukuListTile(daftarBuku[0]),
            bukuListTile(daftarBuku[1]),
            bukuListTile(daftarBuku[2]),
          ],
        ),
      );
    }

    //Ini bagian hasil pencarian
    List<Map<String, String>> hasil =
    hasilPencarian();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'Hasil pencarian untuk "$keyword"',
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),
          //Ini bagian saat buku tidak ditemukan
          if (hasil.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 60,
                      color: Colors.grey,
                    ),

                    SizedBox(height: 15),
                    Text(
                      'Buku tidak ditemukan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          //Ini bagian daftar hasil pencarian
          if (hasil.isNotEmpty)
            Column(
              children: [
                for (int i = 0; i < hasil.length; i++)
                  bukuListTile(hasil[i]),
              ],
            ),
        ],
      ),
    );
  }

  //Ini bagian kartu buku pada Mungkin Anda Suka
  Widget kartuBuku(
      Map<String, String> buku) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              '${buku['judul']} dipilih',
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 155,
        margin: const EdgeInsets.only(
          right: 15,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            //Ini bagian cover buku
            Container(
              width: 155,
              height: 205,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(
                    buku['gambar']!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),
            //Ini bagian judul buku
            Text(
              buku['judul']!,
              maxLines: 1,
              overflow:
              TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),
            //Ini bagian penulis buku
            Text(
              buku['penulis']!,
              maxLines: 1,
              overflow:
              TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),
            //Ini bagian kategori buku
            Text(
              buku['kategori']!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Ini bagian Pencarian Populer
  Widget pencarianPopuler(String teks) {
    return InkWell(
      onTap: () {
        searchController.text = teks;
        setState(() {});
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.grey,
            ),

            const SizedBox(width: 15),
            Text(
              teks,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Ini bagian daftar Buku Pilihan
  Widget bukuListTile(
      Map<String, String> buku) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              '${buku['judul']} dipilih',
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Row(
          children: [
            //Ini bagian cover buku
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(
                    buku['gambar']!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 15),
            //Ini bagian informasi buku
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    buku['judul']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),
                  Text(
                    buku['penulis']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 5),
                  Text(
                    buku['kategori']!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Ini bagian tombol Kategori
  Widget kategoriButton(String nama) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              'Kategori $nama dipilih',
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF1F1F1),
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Text(
          nama,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  //Ini bagian Navbar bawah
  Widget _buildBottomNavigation(
      bool isMobile) {
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
            //Ini bagian Beranda
            _BottomMenu(
              icon:
              'images/assets/home_btn.png',
              label: 'Beranda',
              selected: false,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const HomePage(),
                  ),
                );
              },
            ),

            //Ini bagian Eksplorasi
            _BottomMenu(
              icon:
              'images/assets/search_btn_blue.png',
              label: 'Eksplorasi',
              selected: true,
              onTap: () {},
            ),

            //Ini bagian Koleksi
            _BottomMenu(
              icon:
              'images/assets/book_btn.png',
              label: 'Koleksi',
              selected: false,
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
              icon:
              'images/assets/profile_btn.png',
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


//Ini bagian item Navbar
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
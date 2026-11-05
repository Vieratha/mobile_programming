import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../services/music_api.dart';
import '../widgets/app_sidebar.dart';
import '../widgets/app_header.dart';
import '../widgets/mini_player.dart';
import 'search_page.dart';
import 'now_playing_page.dart';
import 'library_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Menu: Home = 0, Search = 1, Library = 2,
  // Now Playing = 3, Profile = 4
  int selectedMenu = 0;

  // Pencarian musik
  final TextEditingController searchController =
  TextEditingController();

  final MusicApi musicApi = MusicApi();

  List songs = [];
  bool isLoading = false;

  // Daftar lagu favorit
  List<Map<String, dynamic>> favoriteSongs = [];

  // Pemutar musik
  final AudioPlayer player = AudioPlayer();

  Map<String, dynamic>? currentSong;
  int currentIndex = -1;
  bool isLoadingAudio = false;
  bool isPlaying = false;

  // Data profil pengguna
  String namaProfil = 'Indra Kurniawan';
  String emailProfil = 'vietha@gmail.com';
  String bioProfil = 'Music is part of my everyday life.';
  IconData avatarProfil = Icons.person;

  @override
  void dispose() {
    searchController.dispose();
    player.dispose();
    super.dispose();
  }

  // Mengubah URL artwork menjadi resolusi lebih tinggi
  String artworkHD(Map<String, dynamic> song) {
    final String url = song['artworkUrl100'] ?? '';

    return url
        .replaceAll('100x100bb', '600x600bb')
        .replaceAll('100x100', '600x600');
  }

  // Memeriksa apakah lagu sudah menjadi favorit
  bool isFavorite(Map<String, dynamic> song) {
    return favoriteSongs.any(
          (item) => item['trackId'] == song['trackId'],
    );
  }

  // Menambahkan atau menghapus lagu favorit
  void toggleFavorite(Map<String, dynamic> song) {
    setState(() {
      if (isFavorite(song)) {
        favoriteSongs.removeWhere(
              (item) => item['trackId'] == song['trackId'],
        );
      } else {
        favoriteSongs.add(song);
      }
    });
  }

  // Menyimpan perubahan profil
  void simpanDataProfil(
      String nama,
      String email,
      String bio,
      IconData avatar,
      ) {
    setState(() {
      namaProfil = nama;
      emailProfil = email;
      bioProfil = bio;
      avatarProfil = avatar;
    });
  }

  // Mengambil data lagu dari iTunes API
  Future<void> cariLagu() async {
    final keyword = searchController.text.trim();
    final messenger = ScaffoldMessenger.of(context);

    if (keyword.isEmpty) return;

    setState(() {
      isLoading = true;
      selectedMenu = 1;
    });

    try {
      final hasil = await musicApi.cariLagu(keyword);

      if (!mounted) return;

      final hasilHD = hasil.map((item) {
        final song = Map<String, dynamic>.from(item);

        song['artworkUrl100'] = artworkHD(song);

        return song;
      }).toList();

      setState(() {
        songs = hasilHD;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        songs = [];
        isLoading = false;
      });

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Gagal mengambil data lagu. Coba lagi.'),
        ),
      );
    }
  }

  // Mencari musik berdasarkan kategori
  Future<void> cariKategori(String kategori) async {
    searchController.text = kategori;
    await cariLagu();
  }

  // Memutar lagu tanpa berpindah halaman
  Future<void> putarLagu(
      Map<String, dynamic> song,
      int index,
      ) async {
    final String? audioUrl = song['previewUrl'];
    final messenger = ScaffoldMessenger.of(context);

    if (audioUrl == null || audioUrl.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Preview audio tidak tersedia untuk lagu ini.',
          ),
        ),
      );
      return;
    }

    setState(() {
      currentSong = song;
      currentIndex = index;
      isLoadingAudio = true;
      isPlaying = false;
    });

    try {
      await player.stop();

      if (!mounted) return;

      await player.setUrl(audioUrl);

      if (!mounted) return;

      setState(() {
        isLoadingAudio = false;
        isPlaying = true;
      });

      // Memutar preview lagu
      await player.play();

      if (!mounted) return;

      setState(() {
        isPlaying = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingAudio = false;
        isPlaying = false;
      });

      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Audio gagal diputar. Coba pilih lagu lain.',
          ),
        ),
      );
    }
  }

  // Memutar lagu berikutnya
  Future<void> laguBerikutnya() async {
    if (currentIndex >= 0 &&
        currentIndex < songs.length - 1) {
      final nextIndex = currentIndex + 1;

      await putarLagu(
        Map<String, dynamic>.from(songs[nextIndex]),
        nextIndex,
      );
    }
  }

  // Memutar lagu sebelumnya
  Future<void> laguSebelumnya() async {
    if (currentIndex > 0 &&
        currentIndex < songs.length) {
      final previousIndex = currentIndex - 1;

      await putarLagu(
        Map<String, dynamic>.from(songs[previousIndex]),
        previousIndex,
      );
    }
  }

  // Mengatur tombol Play dan Pause
  Future<void> togglePlayPause() async {
    if (currentSong == null || isLoadingAudio) return;

    if (player.playing) {
      await player.pause();

      if (!mounted) return;

      setState(() {
        isPlaying = false;
      });
    } else {
      setState(() {
        isPlaying = true;
      });

      try {
        await player.play();

        if (!mounted) return;

        setState(() {
          isPlaying = false;
        });
      } catch (e) {
        if (!mounted) return;

        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  // Mengubah halaman
  void pilihMenu(int index) {
    setState(() {
      selectedMenu = index;
    });
  }

  // Kembali dari Now Playing ke halaman Search
  void kembaliDariNowPlaying() {
    setState(() {
      selectedMenu = 1;
    });
  }

  // Menentukan halaman yang ditampilkan
  Widget halamanUtama() {
    if (selectedMenu == 1) {
      return SearchPage(
        songs: songs,
        isLoading: isLoading,
        currentSong: currentSong,
        onSelectSong: putarLagu,
        favoriteSongs: favoriteSongs,
        onFavoriteTap: toggleFavorite,
        isFavorite: isFavorite,
      );
    }

    if (selectedMenu == 2) {
      return LibraryPage(
        favoriteSongs: favoriteSongs,
        currentSong: currentSong,
        isFavorite: isFavorite,
        onFavoriteTap: toggleFavorite,
        onSelectSong: putarLagu,
      );
    }

    if (selectedMenu == 3) {
      return NowPlayingPage(
        currentSong: currentSong,
        isLoadingAudio: isLoadingAudio,
        isPlaying: isPlaying,
        onPrevious: laguSebelumnya,
        onNext: laguBerikutnya,
        onPlayPause: togglePlayPause,
        onBack: kembaliDariNowPlaying,
      );
    }

    if (selectedMenu == 4) {
      return ProfilePage(
        nama: namaProfil,
        email: emailProfil,
        bio: bioProfil,
        avatarIcon: avatarProfil,
        onSave: simpanDataProfil,
      );
    }

    return halamanBeranda();
  }

  // Menampilkan halaman Home
  Widget halamanBeranda() {
    final warna = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good music, good mood.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your music, your moment.',
            style: TextStyle(
              fontSize: 15,
              color: warna.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 30),

          Text(
            'Discover music',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              kategoriCard('Pop', Icons.music_note),
              kategoriCard('R&B', Icons.graphic_eq),
              kategoriCard('Indie', Icons.album_outlined),
            ],
          ),

          const SizedBox(height: 35),

          Text(
            'Start listening',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: warna.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.headphones,
                  size: 35,
                  color: warna.primary,
                ),

                const SizedBox(height: 14),

                Text(
                  'Find your next favorite song.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: warna.onSurface,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'Search for songs and artists to start exploring.',
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 18),

                ElevatedButton(
                  onPressed: () => pilihMenu(1),
                  child: const Text('Explore music'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Membuat kartu kategori musik
  Widget kategoriCard(String title, IconData icon) {
    final warna = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => cariKategori(title),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 145,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: warna.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: warna.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: warna.primary,
              size: 27,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: warna.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 850;

        // Search bar hanya muncul di Search dan Library
        final bool tampilkanSearch =
            selectedMenu == 1 || selectedMenu == 2;

        // Header tidak menampilkan tombol Profile
        // ketika sedang berada di Profile atau Now Playing
        return Scaffold(
          body: SafeArea(
            child: isDesktop
                ? Row(
              children: [
                AppSidebar(
                  selectedMenu: selectedMenu,
                  onMenuSelected: pilihMenu,
                ),

                Expanded(
                  child: Column(
                    children: [
                      if (tampilkanSearch)
                        AppHeader(
                          controller: searchController,
                          onSearch: cariLagu,
                          onProfileTap: () => pilihMenu(4),
                        )
                      else if (selectedMenu == 0)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: IconButton(
                              tooltip: 'Profile',
                              onPressed: () => pilihMenu(4),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),
                              icon: const Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                        ),

                      Expanded(
                        child: halamanUtama(),
                      ),

                      MiniPlayer(
                        currentSong: currentSong,
                        isLoadingAudio: isLoadingAudio,
                        isPlaying: isPlaying,
                        onPrevious: laguSebelumnya,
                        onNext: laguBerikutnya,
                        onPlayPause: togglePlayPause,
                        onOpenPlayer: () => pilihMenu(3),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Column(
              children: [
                if (tampilkanSearch)
                  AppHeader(
                    controller: searchController,
                    onSearch: cariLagu,
                    onProfileTap: () => pilihMenu(4),
                  )
                else if (selectedMenu == 0)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      child: IconButton(
                        tooltip: 'Profile',
                        onPressed: () => pilihMenu(4),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .secondaryContainer,
                          foregroundColor: Theme.of(context)
                              .colorScheme
                              .primary,
                        ),
                        icon: const Icon(
                          Icons.person_outline,
                        ),
                      ),
                    ),
                  ),

                Expanded(
                  child: halamanUtama(),
                ),

                MiniPlayer(
                  currentSong: currentSong,
                  isLoadingAudio: isLoadingAudio,
                  isPlaying: isPlaying,
                  onPrevious: laguSebelumnya,
                  onNext: laguBerikutnya,
                  onPlayPause: togglePlayPause,
                  onOpenPlayer: () => pilihMenu(3),
                ),

                NavigationBar(
                  selectedIndex:
                  selectedMenu > 2 ? 0 : selectedMenu,
                  onDestinationSelected: pilihMenu,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),

                    NavigationDestination(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),

                    NavigationDestination(
                      icon: Icon(Icons.library_music_outlined),
                      selectedIcon: Icon(Icons.library_music),
                      label: 'Library',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
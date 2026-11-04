import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../services/music_api.dart';
import '../widgets/app_sidebar.dart';
import '../widgets/app_header.dart';
import '../widgets/mini_player.dart';
import 'search_page.dart';
import 'now_playing_page.dart';
import 'library_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ini bagian navigasi aplikasi
  int selectedMenu = 0;

  // Ini bagian pencarian lagu
  final searchController = TextEditingController();
  final MusicApi musicApi = MusicApi();
  List songs = [];
  bool isLoading = false;

  // Ini bagian audio player
  final AudioPlayer player = AudioPlayer();

  Map<String, dynamic>? currentSong;
  int currentIndex = -1;
  bool isLoadingAudio = false;

  // Ini bagian untuk mengatur proses pergantian lagu
  int audioRequestId = 0;
  int searchRequestId = 0;
  Future<void> audioQueue = Future<void>.value();

  @override
  void dispose() {
    searchController.dispose();
    // Mengakhiri audio player ketika halaman ditutup
    unawaited(player.dispose());

    super.dispose();
  }

  // Ini bagian untuk mencari lagu
  Future<void> cariLagu() async {
    final keyword = searchController.text.trim();
    if (keyword.isEmpty) return;

    // Membuat nomor pencarian baru
    final int thisSearch = ++searchRequestId;
    setState(() {
      isLoading = true;
      selectedMenu = 1;
    });

    try {
      // Mengambil data lagu dari MusicApi
      final hasil = await musicApi.cariLagu(keyword);

      if (!mounted || thisSearch != searchRequestId) return;

      setState(() {
        songs = hasil;

        // Memperbarui posisi lagu pada hasil pencarian baru
        currentIndex = currentSong == null
            ? -1
            : songs.indexWhere(
              (song) =>
          song['trackId'] == currentSong!['trackId'],
        );

        isLoading = false;
      });

    } catch (e) {
      debugPrint('Search error: $e');

      if (!mounted || thisSearch != searchRequestId) return;

      setState(() {
        songs = [];
        currentIndex = -1;
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengambil data lagu. Coba lagi.'),
        ),
      );
    }
  }

  // ==========================================
  // BAGIAN AUDIO PLAYER
  // ==========================================

  // Ini bagian untuk memutar lagu yang dipilih
  Future<void> putarLagu(
      Map<String, dynamic> song,
      int index,
      ) async {

    final String? audioUrl = song['previewUrl'];

    // Memeriksa ketersediaan preview audio
    if (audioUrl == null || audioUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preview audio tidak tersedia untuk lagu ini.',
          ),
        ),
      );
      return;
    }

    // Membuat nomor permintaan audio baru
    final int thisRequest = ++audioRequestId;

    setState(() {
      currentSong = song;
      currentIndex = index;
      isLoadingAudio = true;
    });

    // Memasukkan proses pergantian lagu ke dalam antrean
    audioQueue = audioQueue.then((_) async {

      // Memeriksa apakah lagu masih menjadi pilihan terbaru
      if (!mounted || thisRequest != audioRequestId) return;

      try {
        // Menghentikan audio sebelumnya
        await player.stop();

        if (!mounted || thisRequest != audioRequestId) return;

        // Memuat audio dari URL lagu baru
        await player.setUrl(audioUrl);

        if (!mounted || thisRequest != audioRequestId) return;

        setState(() {
          isLoadingAudio = false;
        });

        // Memulai audio tanpa menunggu sampai lagu selesai
        unawaited(
          player.play().catchError((error) {
            debugPrint('Playback error: $error');
          }),
        );

      } catch (e) {
        debugPrint('Audio error: $e');

        if (!mounted || thisRequest != audioRequestId) return;

        setState(() {
          isLoadingAudio = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Audio gagal diputar. Coba pilih lagu lain.'),
          ),
        );
      }
    });

    await audioQueue;
  }

  // Ini bagian untuk memutar lagu berikutnya
  void laguBerikutnya() {
    if (currentIndex >= 0 &&
        currentIndex < songs.length - 1) {

      final nextIndex = currentIndex + 1;

      unawaited(
        putarLagu(
          Map<String, dynamic>.from(songs[nextIndex]),
          nextIndex,
        ),
      );
    }
  }

  // Ini bagian untuk memutar lagu sebelumnya
  void laguSebelumnya() {
    if (currentIndex > 0 &&
        currentIndex < songs.length) {

      final previousIndex = currentIndex - 1;

      unawaited(
        putarLagu(
          Map<String, dynamic>.from(songs[previousIndex]),
          previousIndex,
        ),
      );
    }
  }

  // Ini bagian untuk play dan pause
  void togglePlayPause() {
    if (currentSong == null || isLoadingAudio) return;

    if (player.playing) {
      unawaited(player.pause());
    } else {
      unawaited(
        player.play().catchError((error) {
          debugPrint('Playback error: $error');
        }),
      );
    }
  }

  // ==========================================
  // BAGIAN NAVIGASI
  // ==========================================

  // Ini bagian untuk memilih menu
  void pilihMenu(int index) {
    setState(() {
      selectedMenu = index;
    });
  }

  // Ini bagian untuk menentukan halaman
  Widget halamanUtama() {
    if (selectedMenu == 1) {
      return SearchPage(
        songs: songs,
        isLoading: isLoading,
        currentSong: currentSong,
        onSelectSong: putarLagu,
      );

    } else if (selectedMenu == 2) {
      return const LibraryPage();

    } else if (selectedMenu == 3) {
      return NowPlayingPage(
        player: player,
        currentSong: currentSong,
        isLoadingAudio: isLoadingAudio,
        onPrevious: laguSebelumnya,
        onNext: laguBerikutnya,
        onPlayPause: togglePlayPause,
      );

    } else {
      return halamanBeranda();
    }
  }

  // ==========================================
  // BAGIAN KONTEN HOME
  // ==========================================

  // Ini bagian untuk menampilkan halaman Home
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

  // Ini bagian untuk membuat kartu kategori
  Widget kategoriCard(String title, IconData icon) {
    final warna = Theme.of(context).colorScheme;

    return Container(
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
    );
  }

  // ==========================================
  // BAGIAN TAMPILAN UTAMA
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        // Menentukan layout desktop dan mobile
        final bool isDesktop = constraints.maxWidth >= 850;

        return Scaffold(
          body: SafeArea(
            child: isDesktop

            // Ini bagian layout desktop
                ? Row(
              children: [
                AppSidebar(
                  selectedMenu: selectedMenu,
                  onMenuSelected: pilihMenu,
                ),

                Expanded(
                  child: Column(
                    children: [
                      AppHeader(
                        controller: searchController,
                        onSearch: cariLagu,
                      ),

                      Expanded(
                        child: halamanUtama(),
                      ),

                      MiniPlayer(
                        player: player,
                        currentSong: currentSong,
                        isLoadingAudio: isLoadingAudio,
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

            // Ini bagian layout mobile
                : Column(
              children: [
                AppHeader(
                  controller: searchController,
                  onSearch: cariLagu,
                ),

                Expanded(
                  child: halamanUtama(),
                ),

                MiniPlayer(
                  player: player,
                  currentSong: currentSong,
                  isLoadingAudio: isLoadingAudio,
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
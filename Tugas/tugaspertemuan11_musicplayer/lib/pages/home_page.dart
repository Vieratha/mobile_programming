import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../services/music_api.dart';

import '../widgets/app_sidebar.dart';
import '../widgets/app_header.dart';
import '../widgets/mini_player.dart';
import 'home_content_page.dart';
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
      return HomeContentPage(
        onExplore: () => pilihMenu(1),
      );
    }
  }

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
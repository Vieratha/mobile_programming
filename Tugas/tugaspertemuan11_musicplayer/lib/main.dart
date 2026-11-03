import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

//(Untuk AI) Bagian ini ubah atau pindahkan
const Color bgColor = Color(0xFF111114);
const Color sidebarColor = Color(0xFF19191F);
const Color cardColor = Color(0xFF222229);
const Color borderColor = Color(0xFF343139);
const Color primaryColor = Color(0xFFE83D70);
const Color secondaryColor = Color(0xFFA6A0A8);
const Color textColor = Color(0xFFF4F1F3);

void main() {
  runApp(const IvylodiaApp());
}

class IvylodiaApp extends StatelessWidget {
  const IvylodiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ivylodia',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: primaryColor,
          surface: cardColor,
        ),
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

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
  List songs = [];
  bool isLoading = false;

  // Ini bagian audio player
  final AudioPlayer player = AudioPlayer();
  Map<String, dynamic>? currentSong;
  int currentIndex = -1;
  bool isLoadingAudio = false;

  @override
  void dispose() {
    searchController.dispose();
    player.dispose();
    super.dispose();
  }

  // Ini bagian untuk mencari lagu melalui iTunes API
  Future<void> cariLagu() async {
    if (searchController.text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      selectedMenu = 1;
    });

    final url = Uri.https(
      'itunes.apple.com',
      '/search',
      {
        'term': searchController.text.trim(),
        'limit': '20',
        'entity': 'song',
      },
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (!mounted) return;

        setState(() {
          songs = data['results'];
        });
      } else {
        if (!mounted) return;

        setState(() {
          songs = [];
        });
      }
    } catch (e) {
      debugPrint('Search error: $e');

      if (!mounted) return;

      setState(() {
        songs = [];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengambil data lagu. Coba lagi.'),
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  // Ini bagian untuk memutar lagu yang dipilih
  Future<void> putarLagu(Map<String, dynamic> song, int index) async {
    final String? audioUrl = song['previewUrl'];

    if (audioUrl == null || audioUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preview audio tidak tersedia untuk lagu ini.'),
        ),
      );
      return;
    }

    setState(() {
      currentSong = song;
      currentIndex = index;
      isLoadingAudio = true;
    });

    try {
      await player.setUrl(audioUrl);

      if (!mounted) return;

      setState(() {
        isLoadingAudio = false;
      });

      player.play();
    } catch (e) {
      debugPrint('Audio error: $e');

      if (!mounted) return;

      setState(() {
        isLoadingAudio = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Audio gagal diputar.'),
        ),
      );
    }
  }

  // Ini bagian untuk memutar lagu berikutnya
  void laguBerikutnya() {
    if (currentIndex < songs.length - 1 && currentIndex >= 0) {
      final nextIndex = currentIndex + 1;

      putarLagu(
        Map<String, dynamic>.from(songs[nextIndex]),
        nextIndex,
      );
    }
  }

  // Ini bagian untuk memutar lagu sebelumnya
  void laguSebelumnya() {
    if (currentIndex > 0) {
      final previousIndex = currentIndex - 1;

      putarLagu(
        Map<String, dynamic>.from(songs[previousIndex]),
        previousIndex,
      );
    }
  }

  // Ini bagian untuk memilih menu
  void pilihMenu(int index) {
    setState(() {
      selectedMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 850;

        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: isDesktop
                ? Row(
              children: [
                sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      header(),
                      Expanded(child: halamanUtama()),
                      miniPlayer(),
                    ],
                  ),
                ),
              ],
            )
                : Column(
              children: [
                header(),
                Expanded(child: halamanUtama()),
                miniPlayer(),
                NavigationBar(
                  backgroundColor: sidebarColor,
                  indicatorColor: const Color(0xFF351A25),
                  selectedIndex: selectedMenu > 2 ? 0 : selectedMenu,
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

  // Ini bagian sidebar desktop
  Widget sidebar() {
    return Container(
      width: 230,
      color: sidebarColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ivylodia',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'MENU',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          menuItem(Icons.home_outlined, 'Home', 0),
          menuItem(Icons.search, 'Search', 1),
          menuItem(Icons.library_music_outlined, 'Your Library', 2),
          const Spacer(),
          const Divider(color: borderColor),
          const Text(
            'IVYLODIA MUSIC',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian item navigasi sidebar
  Widget menuItem(IconData icon, String title, int index) {
    final bool active = selectedMenu == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        selected: active,
        selectedTileColor: const Color(0xFF351A25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Icon(
          icon,
          color: active ? primaryColor : secondaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: active ? primaryColor : textColor,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => pilihMenu(index),
      ),
    );
  }

  // Ini bagian header dan kolom pencarian
  Widget header() {
    final bool isMobile = MediaQuery.of(context).size.width < 850;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 18,
      ),
      child: Row(
        children: [
          if (isMobile) ...[
            const Text(
              'Ivylodia',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 18),
          ],
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: textColor),
                onSubmitted: (_) => cariLagu(),
                decoration: InputDecoration(
                  hintText: 'Search songs, artists...',
                  hintStyle: const TextStyle(color: secondaryColor),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: textColor,
                    ),
                    onPressed: cariLagu,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          const CircleAvatar(
            backgroundColor: Color(0xFF351A25),
            child: Icon(
              Icons.person_outline,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian untuk menentukan halaman
  Widget halamanUtama() {
    if (selectedMenu == 1) {
      return halamanSearch();
    } else if (selectedMenu == 2) {
      return halamanLibrary();
    } else if (selectedMenu == 3) {
      return halamanNowPlaying();
    } else {
      return halamanHome();
    }
  }

  // Ini bagian halaman Home
  Widget halamanHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good music, good mood.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your music, your moment.',
            style: TextStyle(
              fontSize: 15,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Discover music',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: textColor,
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
          const Text(
            'Start listening',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.headphones,
                  size: 35,
                  color: primaryColor,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Find your next favorite song.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Search for songs and artists to start exploring.',
                  style: TextStyle(color: secondaryColor),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => pilihMenu(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Explore music'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian kartu kategori musik
  Widget kategoriCard(String title, IconData icon) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 27),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian halaman Search
  Widget halamanSearch() {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Find songs and artists you love.',
            style: TextStyle(color: secondaryColor),
          ),
          const SizedBox(height: 22),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            )
          else if (songs.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      size: 55,
                      color: secondaryColor,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Search for your favorite music',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        song['artworkUrl100'] ?? '',
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            width: 52,
                            height: 52,
                            color: cardColor,
                            child: const Icon(
                              Icons.music_note,
                              color: primaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      song['trackName'] ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      song['artistName'] ?? '-',
                      maxLines: 1,
                      style: const TextStyle(color: secondaryColor),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.play_circle_outline,
                        color: primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        putarLagu(
                          Map<String, dynamic>.from(song),
                          index,
                        );
                      },
                    ),
                    onTap: () {
                      putarLagu(
                        Map<String, dynamic>.from(song),
                        index,
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // Ini bagian halaman Library
  Widget halamanLibrary() {
    return const Padding(
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Library',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 20),
          Icon(
            Icons.library_music_outlined,
            size: 55,
            color: secondaryColor,
          ),
          SizedBox(height: 12),
          Text(
            'Your music collection will appear here.',
            style: TextStyle(color: secondaryColor),
          ),
        ],
      ),
    );
  }

  // Ini bagian halaman Now Playing
  Widget halamanNowPlaying() {
    if (currentSong == null) {
      return const Center(
        child: Text(
          'Choose a song first.',
          style: TextStyle(color: secondaryColor),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          const Text(
            'NOW PLAYING',
            style: TextStyle(
              color: secondaryColor,
              letterSpacing: 2,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 28),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              currentSong?['artworkUrl100'] ?? '',
              width: 280,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 280,
                  height: 280,
                  color: cardColor,
                  child: const Icon(
                    Icons.music_note,
                    size: 90,
                    color: primaryColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Text(
            currentSong?['trackName'] ?? '-',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            currentSong?['artistName'] ?? '-',
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = player.duration ?? Duration.zero;

              final maxValue = duration.inMilliseconds > 0
                  ? duration.inMilliseconds.toDouble()
                  : 1.0;

              final currentValue = position.inMilliseconds
                  .toDouble()
                  .clamp(0.0, maxValue);

              return Column(
                children: [
                  Slider(
                    value: currentValue,
                    max: maxValue,
                    activeColor: primaryColor,
                    inactiveColor: borderColor,
                    onChanged: (value) {
                      player.seek(
                        Duration(milliseconds: value.toInt()),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDurasi(position),
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        formatDurasi(duration),
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: laguSebelumnya,
                    icon: const Icon(
                      Icons.skip_previous,
                      color: textColor,
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      if (isLoadingAudio) return;

                      if (playing) {
                        player.pause();
                      } else {
                        player.play();
                      }
                    },
                    icon: Icon(
                      playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: primaryColor,
                      size: 65,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: laguBerikutnya,
                    icon: const Icon(
                      Icons.skip_next,
                      color: textColor,
                      size: 35,
                    ),
                  ),
                ],
              );
            },
          ),
          if (isLoadingAudio)
            const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(color: primaryColor),
            ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur lirik akan kita buat di tahap berikutnya.'),
                ),
              );
            },
            icon: const Icon(Icons.lyrics_outlined),
            label: const Text('View Lyrics'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              side: const BorderSide(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian mini player di bawah aplikasi
  Widget miniPlayer() {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: const BoxDecoration(
        color: sidebarColor,
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: Row(
        children: [
          if (currentSong != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                currentSong?['artworkUrl100'] ?? '',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 48,
                    height: 48,
                    color: cardColor,
                    child: const Icon(
                      Icons.music_note,
                      color: primaryColor,
                    ),
                  );
                },
              ),
            )
          else
            const Icon(
              Icons.music_note,
              color: primaryColor,
              size: 30,
            ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (currentSong != null) pilihMenu(3);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentSong?['trackName'] ?? 'No song selected',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    currentSong?['artistName'] ?? 'Choose a song to begin',
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: laguSebelumnya,
            icon: const Icon(Icons.skip_previous, color: textColor),
          ),
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;

              return IconButton(
                onPressed: currentSong == null || isLoadingAudio
                    ? null
                    : () {
                  if (playing) {
                    player.pause();
                  } else {
                    player.play();
                  }
                },
                icon: Icon(
                  playing
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: primaryColor,
                  size: 40,
                ),
              );
            },
          ),
          IconButton(
            onPressed: laguBerikutnya,
            icon: const Icon(Icons.skip_next, color: textColor),
          ),
        ],
      ),
    );
  }

  // Ini bagian untuk mengubah durasi menjadi menit dan detik
  String formatDurasi(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

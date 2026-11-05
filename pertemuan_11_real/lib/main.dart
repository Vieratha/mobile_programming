import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111114),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE83D70),
          surface: Color(0xFF19191F),
          onSurface: Color(0xFFF4F1F3),
          onSurfaceVariant: Color(0xFFA6A0A8),
        ),
        fontFamily: 'Arial',
      ),
      home: const MusicPage(),
    );
  }
}

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final TextEditingController controller = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();
  List<Map<String, dynamic>> songs = [];
  Map<String, dynamic>? currentSong;
  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  String getArtwork(Map<String, dynamic> song) {
    String artwork = song['artworkUrl100'] ?? '';

    return artwork.replaceFirst(
      '100x100bb',
      '600x600bb',
    );
  }

  Future<void> cariLagu() async {
    String keyword = controller.text.trim();

    if (keyword.isEmpty) return;

    setState(() {
      isLoading = true;
      songs = [];
    });

    final url = Uri.https(
      'itunes.apple.com',
      '/search',
      <String, String>{
        'term': keyword,
        'limit': '20',
        'entity': 'song',
      },
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          songs = (data['results'] as List)
              .map(
                (item) => Map<String, dynamic>.from(item),
          )
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengambil data musik.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mencari musik. Periksa internet.'),
        ),
      );
      debugPrint('SEARCH ERROR: $e');
    }
  }

  Future<void> putarLagu(Map<String, dynamic> song) async {
    String? audioUrl = song['previewUrl'];

    if (audioUrl == null || audioUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preview audio tidak tersedia.'),
        ),
      );
      return;
    }

    bool laguSama =
        currentSong?['trackId'] == song['trackId'];

    // Pause jika lagu yang sama sedang diputar
    if (laguSama && audioPlayer.playing) {
      await audioPlayer.pause();
      return;
    }

    try {
      // Melanjutkan lagu yang sama
      if (laguSama &&
          audioPlayer.processingState != ProcessingState.idle &&
          audioPlayer.processingState != ProcessingState.completed) {
        audioPlayer.play().catchError((error) {
          debugPrint('PLAY ERROR: $error');
        });
        return;
      }

      // Mengganti lagu aktif
      setState(() {
        currentSong = song;
      });

      // Menghentikan lagu sebelumnya
      await audioPlayer.stop();

      // Memuat audio baru
      await audioPlayer.setUrl(audioUrl);

      // Memulai pemutaran
      audioPlayer.play().catchError((error) {
        debugPrint('PLAY ERROR: $error');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Audio error: $error'),
            ),
          );
        }
      });
    } catch (e) {
      debugPrint('AUDIO ERROR: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memutar audio: $e'),
          ),
        );
      }
    }
  }

  void togglePlayPause() {
    if (currentSong == null) return;

    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  Widget daftarLagu(Map<String, dynamic> song) {
    final warna = Theme.of(context).colorScheme;
    bool dipilih =
        currentSong?['trackId'] == song['trackId'];

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: dipilih
            ? const Color(0xFF422334)
            : warna.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: dipilih
              ? warna.primary
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 3,
        ),

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.network(
            getArtwork(song),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 50,
                height: 50,
                color: warna.surface,
                child: Icon(
                  Icons.music_note,
                  color: warna.primary,
                ),
              );
            },
          ),
        ),

        title: Text(
          song['trackName'] ?? '-',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: dipilih
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),

        subtitle: Text(
          song['artistName'] ?? '-',
          maxLines: 1,
        ),

        trailing: StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final bool sedangDiputar =
                snapshot.data?.playing ?? false;

            return IconButton(
              onPressed: () => putarLagu(song),
              icon: Icon(
                dipilih && sedangDiputar
                    ? Icons.equalizer
                    : Icons.play_circle_outline,
                color: warna.primary,
                size: 27,
              ),
            );
          },
        ),

        onTap: () => putarLagu(song),
      ),
    );
  }

  Widget halamanDiscover() {
    final warna = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discover Music',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),
          Text(
            'Temukan musik favoritmu.',
            style: TextStyle(
              color: warna.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 22),
          TextField(
            controller: controller,
            onSubmitted: (_) => cariLagu(),
            decoration: InputDecoration(
              hintText: 'Cari judul lagu atau artis...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: warna.primary,
                ),
                onPressed: cariLagu,
              ),
              filled: true,
              fillColor: warna.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),
          const Text(
            'Hasil Pencarian',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (songs.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Cari musik untuk memulai.',
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return daftarLagu(songs[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget sidebar() {
    final warna = Theme.of(context).colorScheme;

    return Container(
      width: 230,
      color: const Color(0xFF19191F),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Ivylodia',
              style: TextStyle(
                color: Color(0xFFE83D70),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),
          Text(
            'MENU',
            style: TextStyle(
              color: warna.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: warna.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.library_music,
                  color: warna.primary,
                ),

                const SizedBox(width: 15),
                Text(
                  'Discover',
                  style: TextStyle(
                    color: warna.primary,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'IVYLODIA MUSIC',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget miniPlayer() {
    if (currentSong == null) {
      return const SizedBox.shrink();
    }

    final warna = Theme.of(context).colorScheme;

    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final bool sedangDiputar =
            snapshot.data?.playing ?? false;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: warna.surface,
            border: Border(
              top: BorderSide(
                color: warna.outline,
              ),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  getArtwork(currentSong!),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 48,
                      height: 48,
                      color: warna.surface,
                      child: Icon(
                        Icons.music_note,
                        color: warna.primary,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentSong!['trackName'] ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      currentSong!['artistName'] ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: warna.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),

                    Text(
                      sedangDiputar ? 'Now Playing' : 'Paused',
                      style: TextStyle(
                        color: warna.primary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: togglePlayPause,
                icon: Icon(
                  sedangDiputar
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: warna.primary,
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          sidebar(),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: halamanDiscover(),
                ),
                miniPlayer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
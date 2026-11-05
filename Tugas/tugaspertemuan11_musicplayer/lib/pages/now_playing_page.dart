import 'package:flutter/material.dart';

class NowPlayingPage extends StatelessWidget {
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final bool isPlaying;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;

  const NowPlayingPage({
    super.key,
    required this.currentSong,
    required this.isLoadingAudio,
    required this.isPlaying,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    if (currentSong == null) {
      return Center(
        child: Text(
          'Choose a song first.',
          style: TextStyle(
            color: warna.onSurfaceVariant,
          ),
        ),
      );
    }

    final double artworkSize =
    MediaQuery.of(context).size.width < 500 ? 260 : 320;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            'NOW PLAYING',
            style: TextStyle(
              color: warna.onSurfaceVariant,
              letterSpacing: 2,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 28),

          // Cover lagu
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              currentSong!['artworkUrl100'] ?? '',
              width: artworkSize,
              height: artworkSize,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Container(
                  width: artworkSize,
                  height: artworkSize,
                  color: warna.surface,
                  child: Icon(
                    Icons.music_note,
                    size: 90,
                    color: warna.primary,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          // Judul lagu
          Text(
            currentSong!['trackName'] ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 7),

          // Nama artis
          Text(
            currentSong!['artistName'] ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: warna.onSurfaceVariant,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 30),

          // Kontrol pemutaran musik
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onPrevious,
                icon: Icon(
                  Icons.skip_previous,
                  color: warna.onSurface,
                  size: 35,
                ),
              ),

              const SizedBox(width: 20),

              IconButton(
                onPressed: isLoadingAudio ? null : onPlayPause,
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: warna.primary,
                  size: 65,
                ),
              ),

              const SizedBox(width: 20),

              IconButton(
                onPressed: onNext,
                icon: Icon(
                  Icons.skip_next,
                  color: warna.onSurface,
                  size: 35,
                ),
              ),
            ],
          ),

          if (isLoadingAudio)
            const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
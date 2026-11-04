import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingPage extends StatelessWidget {
  final AudioPlayer player;
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;

  const NowPlayingPage({
    super.key,
    required this.player,
    required this.currentSong,
    required this.isLoadingAudio,
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
          style: TextStyle(color: warna.onSurfaceVariant),
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
          // Ini bagian cover lagu
          ClipRRect(
            borderRadius: BorderRadius.circular(16),

            child: Image.network(
              currentSong!['artworkUrl100'] ?? '',
              width: artworkSize,
              height: artworkSize,
              fit: BoxFit.cover,

              errorBuilder: (_, __, ___) {
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
          Text(
            currentSong!['artistName'] ?? '-',
            style: TextStyle(
              color: warna.onSurfaceVariant,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),
          // Ini bagian progress dan durasi audio
          StreamBuilder<Duration?>(
            stream: player.durationStream,

            builder: (context, durationSnapshot) {
              final duration =
                  durationSnapshot.data ?? Duration.zero;

              final maxValue = duration.inMilliseconds > 0
                  ? duration.inMilliseconds.toDouble()
                  : 1.0;

              return StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, positionSnapshot) {
                  final position =
                      positionSnapshot.data ?? Duration.zero;
                  final currentValue = position.inMilliseconds
                      .toDouble()
                      .clamp(0.0, maxValue)
                      .toDouble();

                  return Column(
                    children: [
                      Slider(
                        value: currentValue,
                        max: maxValue,
                        activeColor: warna.primary,
                        inactiveColor: warna.outline,
                        onChanged: duration.inMilliseconds <= 0
                            ? null
                            : (value) {
                          player.seek(
                            Duration(
                              milliseconds: value.toInt(),
                            ),
                          );
                        },
                      ),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDurasi(position),
                            style: TextStyle(
                              color: warna.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            formatDurasi(duration),
                            style: TextStyle(
                              color: warna.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 12),

          // Ini bagian kontrol musik
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;

              return Row(
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
                      playing
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
              );
            },
          ),

          if (isLoadingAudio)
            const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ),

          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Fitur lirik akan ditambahkan berikutnya.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.lyrics_outlined),
            label: const Text('View Lyrics'),
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
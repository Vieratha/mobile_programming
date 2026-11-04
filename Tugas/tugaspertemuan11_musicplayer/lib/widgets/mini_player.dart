import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MiniPlayer extends StatelessWidget {
  final AudioPlayer player;
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;
  final VoidCallback onOpenPlayer;

  const MiniPlayer({
    super.key,
    required this.player,
    required this.currentSong,
    required this.isLoadingAudio,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
    required this.onOpenPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: warna.surface,
        border: Border(
          top: BorderSide(color: warna.outline),
        ),
      ),
      child: Row(
        children: [
          //Cover lagu
          if (currentSong != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                currentSong!['artworkUrl100'] ?? '',
                width: 48,
                height: 48,
                fit: BoxFit.cover,

                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 48,
                    height: 48,
                    color: warna.secondaryContainer,
                    child: Icon(
                      Icons.music_note,
                      color: warna.primary,
                    ),
                  );
                },
              ),
            )
          else
            Icon(
              Icons.music_note,
              color: warna.primary,
              size: 30,
            ),

          const SizedBox(width: 12),
          // Informasi lagu
          Expanded(
            child: InkWell(
              onTap: currentSong == null ? null : onOpenPlayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentSong?['trackName'] ?? 'No song selected',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: warna.onSurface,
                    ),
                  ),

                  Text(
                    currentSong?['artistName'] ?? 'Choose a song to begin',
                    maxLines: 1,
                    style: TextStyle(
                      color: warna.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            onPressed: currentSong == null ? null : onPrevious,
            icon: const Icon(Icons.skip_previous),
          ),

          // Tombol play dan pause mengikuti kondisi audio
          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;

              return IconButton(
                onPressed: currentSong == null || isLoadingAudio
                    ? null
                    : onPlayPause,
                icon: Icon(
                  playing
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: warna.primary,
                  size: 40,
                ),
              );
            },
          ),
          IconButton(
            onPressed: currentSong == null ? null : onNext,
            icon: const Icon(Icons.skip_next),
          ),
        ],
      ),
    );
  }
}

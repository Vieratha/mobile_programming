import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final bool isPlaying;
  final IconData avatarIcon;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;
  final VoidCallback onOpenPlayer;

  const MiniPlayer({
    super.key,
    required this.currentSong,
    required this.isLoadingAudio,
    required this.isPlaying,
    required this.avatarIcon,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
    required this.onOpenPlayer,
  });

  String artworkHD(Map<String, dynamic> song) {
    final String url = song['artworkUrl100'] ?? '';

    return url
        .replaceAll('100x100bb', '600x600bb')
        .replaceAll('100x100', '600x600');
  }

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
          // Cover lagu
          if (currentSong != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                artworkHD(currentSong!),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
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
                    currentSong?['artistName'] ??
                        'Choose a song to begin',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: warna.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Membuka Now Playing
          IconButton(
            tooltip: 'Open Now Playing',
            onPressed: currentSong == null ? null : onOpenPlayer,
            icon: const Icon(Icons.open_in_full),
          ),

          // Play dan Pause
          IconButton(
            onPressed: currentSong == null || isLoadingAudio
                ? null
                : onPlayPause,
            icon: Icon(
              isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: warna.primary,
              size: 40,
            ),
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
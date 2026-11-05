import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final bool isPlaying;
  final bool isFavorite;
  final IconData avatarIcon;

  final VoidCallback onFavoriteTap;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;
  final VoidCallback onOpenPlayer;

  const MiniPlayer({
    super.key,
    required this.currentSong,
    required this.isLoadingAudio,
    required this.isPlaying,
    required this.isFavorite,
    required this.avatarIcon,
    required this.onFavoriteTap,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
    required this.onOpenPlayer,
  });

  // Mengatur artwork agar menggunakan resolusi lebih tinggi
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
              avatarIcon,
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

          // Tombol Favorite
          IconButton(
            tooltip: isFavorite
                ? 'Remove from Favorites'
                : 'Add to Favorites',
            onPressed:
            currentSong == null ? null : onFavoriteTap,
            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: isFavorite
                  ? warna.primary
                  : warna.onSurfaceVariant,
            ),
          ),

          // Membuka halaman Now Playing
          IconButton(
            tooltip: 'Open Now Playing',
            onPressed: currentSong == null ? null : onOpenPlayer,
            icon: const Icon(Icons.open_in_full),
          ),

          // Play dan Pause
          IconButton(
            tooltip: isPlaying ? 'Pause' : 'Play',
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

          // Lagu berikutnya
          IconButton(
            tooltip: 'Next',
            onPressed: currentSong == null ? null : onNext,
            icon: const Icon(Icons.skip_next),
          ),
        ],
      ),
    );
  }
}
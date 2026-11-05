import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  final Map<String, dynamic> song;
  final bool isSelected;
  final bool isPlaying;
  final bool isFavorite;
  final VoidCallback onPlay;
  final VoidCallback onFavorite;

  const SongTile({
    super.key,
    required this.song,
    required this.isSelected,
    required this.isPlaying,
    required this.isFavorite,
    required this.onPlay,
    required this.onFavorite,
  });

  // Mengubah URL artwork menjadi resolusi lebih tinggi.
  String artworkHD() {
    final String url = song['artworkUrl100'] ?? '';

    return url
        .replaceAll('100x100bb', '600x600bb')
        .replaceAll('100x100', '600x600');
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      selected: isSelected,
      selectedTileColor: warna.secondaryContainer,

      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          artworkHD(),
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) {
            return Container(
              width: 55,
              height: 55,
              color: warna.surface,
              child: Icon(Icons.music_note, color: warna.primary),
            );
          },
        ),
      ),

      title: Text(
        song['trackName'] ?? '-',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: warna.onSurface),
      ),

      subtitle: Text(
        song['artistName'] ?? '-',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: warna.onSurfaceVariant),
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
            onPressed: onFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? warna.primary : warna.onSurfaceVariant,
            ),
          ),

          IconButton(
            tooltip: isPlaying ? 'Currently playing' : 'Play song',
            onPressed: onPlay,
            icon: Icon(
              isPlaying ? Icons.equalizer : Icons.play_circle_outline,
              color: warna.primary,
              size: 30,
            ),
          ),
        ],
      ),

      onTap: onPlay,
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/song_tile.dart';

class LibraryPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteSongs;
  final Map<String, dynamic>? currentSong;
  final bool isPlaying;
  final Function(Map<String, dynamic>) isFavorite;
  final Function(Map<String, dynamic>) onFavoriteTap;
  final Function(Map<String, dynamic>, int) onSelectSong;

  const LibraryPage({
    super.key,
    required this.favoriteSongs,
    required this.currentSong,
    required this.isPlaying,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onSelectSong,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Library',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Your favorite songs in one place.',
            style: TextStyle(color: warna.onSurfaceVariant),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Icon(Icons.favorite, color: warna.primary),

              const SizedBox(width: 9),

              Text(
                'Favorite Songs (${favoriteSongs.length})',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: warna.onSurface,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          if (favoriteSongs.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 65,
                      color: warna.onSurfaceVariant,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'No favorite songs yet.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: warna.onSurface,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      'Add songs to your favorites from Search.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: warna.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: favoriteSongs.length,
                itemBuilder: (context, index) {
                  final song = favoriteSongs[index];

                  final bool selected =
                      currentSong?['trackId'] == song['trackId'];

                  return SongTile(
                    song: song,
                    isSelected: selected,
                    isPlaying: selected && isPlaying,
                    isFavorite: isFavorite(song),
                    onPlay: () {
                      onSelectSong(song, index);
                    },
                    onFavorite: () {
                      onFavoriteTap(song);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

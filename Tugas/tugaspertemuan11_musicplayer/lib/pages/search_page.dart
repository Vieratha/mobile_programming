import 'package:flutter/material.dart';

import '../widgets/song_tile.dart';

class SearchPage extends StatelessWidget {
  final List songs;
  final bool isLoading;
  final Map<String, dynamic>? currentSong;
  final bool isPlaying;
  final Function(Map<String, dynamic>, int) onSelectSong;
  final List<Map<String, dynamic>> favoriteSongs;
  final Function(Map<String, dynamic>) onFavoriteTap;
  final Function(Map<String, dynamic>) isFavorite;

  const SearchPage({
    super.key,
    required this.songs,
    required this.isLoading,
    required this.currentSong,
    required this.isPlaying,
    required this.onSelectSong,
    required this.favoriteSongs,
    required this.onFavoriteTap,
    required this.isFavorite,
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
            'Search',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Find songs and artists you love.',
            style: TextStyle(color: warna.onSurfaceVariant),
          ),

          const SizedBox(height: 22),

          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (songs.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, size: 55, color: warna.onSurfaceVariant),

                    const SizedBox(height: 12),

                    Text(
                      'Search for your favorite music',
                      style: TextStyle(color: warna.onSurfaceVariant),
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
                  final song = Map<String, dynamic>.from(songs[index]);

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

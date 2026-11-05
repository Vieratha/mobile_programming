import 'package:flutter/material.dart';

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

  String artworkHD(Map<String, dynamic> song) {
    final String url = song['artworkUrl100'] ?? '';

    return url
        .replaceAll('100x100bb', '600x600bb')
        .replaceAll('100x100', '600x600');
  }

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
            style: TextStyle(
              color: warna.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Icon(
                Icons.favorite,
                color: warna.primary,
              ),

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
                      style: TextStyle(
                        color: warna.onSurfaceVariant,
                      ),
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

                  // Equalizer hanya ketika lagu sedang diputar
                  final bool sedangDiputar =
                      selected && isPlaying;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),

                    selected: selected,
                    selectedTileColor: warna.secondaryContainer,

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        artworkHD(song),
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) {
                          return Container(
                            width: 55,
                            height: 55,
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
                        fontWeight: FontWeight.bold,
                        color: warna.onSurface,
                      ),
                    ),

                    subtitle: Text(
                      song['artistName'] ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: warna.onSurfaceVariant,
                      ),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: sedangDiputar
                              ? 'Currently playing'
                              : 'Play song',
                          onPressed: () {
                            onSelectSong(song, index);
                          },
                          icon: Icon(
                            sedangDiputar
                                ? Icons.equalizer
                                : Icons.play_circle_outline,
                            color: warna.primary,
                            size: 30,
                          ),
                        ),

                        IconButton(
                          tooltip: 'Remove from Favorites',
                          onPressed: () => onFavoriteTap(song),
                          icon: Icon(
                            isFavorite(song)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: warna.primary,
                          ),
                        ),
                      ],
                    ),

                    onTap: () {
                      onSelectSong(song, index);
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
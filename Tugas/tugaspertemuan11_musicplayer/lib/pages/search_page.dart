import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List songs;
  final bool isLoading;
  final Map<String, dynamic>? currentSong;
  final Function(Map<String, dynamic>, int) onSelectSong;
  final List<Map<String, dynamic>> favoriteSongs;
  final Function(Map<String, dynamic>) onFavoriteTap;
  final Function(Map<String, dynamic>) isFavorite;

  const SearchPage({
    super.key,
    required this.songs,
    required this.isLoading,
    required this.currentSong,
    required this.onSelectSong,
    required this.favoriteSongs,
    required this.onFavoriteTap,
    required this.isFavorite,
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
            style: TextStyle(
              color: warna.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 22),

          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (songs.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      size: 55,
                      color: warna.onSurfaceVariant,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Search for your favorite music',
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
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = Map<String, dynamic>.from(
                    songs[index],
                  );

                  final bool isSelected =
                      currentSong?['trackId'] == song['trackId'];

                  final bool favorite = isFavorite(song);

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    selected: isSelected,
                    selectedTileColor: warna.secondaryContainer,

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        artworkHD(song),
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) {
                          return Container(
                            width: 52,
                            height: 52,
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
                          tooltip: favorite
                              ? 'Remove from Favorites'
                              : 'Add to Favorites',
                          onPressed: () => onFavoriteTap(song),
                          icon: Icon(
                            favorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favorite
                                ? warna.primary
                                : warna.onSurfaceVariant,
                          ),
                        ),

                        IconButton(
                          tooltip: isSelected
                              ? 'Currently selected'
                              : 'Play song',
                          icon: Icon(
                            isSelected
                                ? Icons.equalizer
                                : Icons.play_circle_outline,
                            color: warna.primary,
                            size: 30,
                          ),
                          onPressed: () {
                            onSelectSong(song, index);
                          },
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
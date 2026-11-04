import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List songs;
  final bool isLoading;
  final Map<String, dynamic>? currentSong;
  final Function(Map<String, dynamic>, int) onSelectSong;

  const SearchPage({
    super.key,
    required this.songs,
    required this.isLoading,
    required this.currentSong,
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
          // Ini bagian untuk menampilkan loading
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )

          // Ini bagian jika hasil pencarian kosong
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

          // Ini bagian untuk menampilkan daftar lagu
          else
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  final bool isSelected =
                      currentSong?['trackId'] == song['trackId'];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    selected: isSelected,
                    selectedTileColor: warna.secondaryContainer,

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        song['artworkUrl100'] ?? '',
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
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
                      style: TextStyle(
                        color: warna.onSurfaceVariant,
                      ),
                    ),

                    trailing: IconButton(
                      icon: Icon(
                        isSelected
                            ? Icons.equalizer
                            : Icons.play_circle_outline,
                        color: warna.primary,
                        size: 30,
                      ),

                      onPressed: () {
                        onSelectSong(
                          Map<String, dynamic>.from(song),
                          index,
                        );
                      },
                    ),

                    onTap: () {
                      onSelectSong(
                        Map<String, dynamic>.from(song),
                        index,
                      );
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
import 'package:flutter/material.dart';

class NowPlayingPage extends StatelessWidget {
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final bool isPlaying;
  final bool isFavorite;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;
  final VoidCallback onBack;
  final VoidCallback onFavoriteTap;

  const NowPlayingPage({
    super.key,
    required this.currentSong,
    required this.isLoadingAudio,
    required this.isPlaying,
    required this.isFavorite,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
    required this.onBack,
    required this.onFavoriteTap,
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

    return Column(
      children: [
        // Tombol kembali
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
            ),
            child: IconButton(
              onPressed: onBack,
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),

        Expanded(
          child: currentSong == null
              ? Center(
            child: Text(
              'Choose a song first.',
              style: TextStyle(
                color: warna.onSurfaceVariant,
              ),
            ),
          )
              : LayoutBuilder(
            builder: (context, constraints) {
              final double artworkSize =
              MediaQuery.of(context).size.width < 500
                  ? 230
                  : 310;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 650,
                    ),
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

                        const SizedBox(height: 22),

                        // Artwork album
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            artworkHD(currentSong!),
                            width: artworkSize,
                            height: artworkSize,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) {
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

                        const SizedBox(height: 24),

                        // Judul lagu
                        Text(
                          currentSong!['trackName'] ?? '-',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: warna.onSurface,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Nama artis dan Favorite
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                currentSong!['artistName'] ?? '-',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: warna.onSurfaceVariant,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            IconButton(
                              tooltip: isFavorite
                                  ? 'Remove from Favorites'
                                  : 'Add to Favorites',
                              onPressed: onFavoriteTap,
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? warna.primary
                                    : warna.onSurfaceVariant,
                                size: 25,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Panel kontrol musik
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: warna.surface,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: warna.outline,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: onPrevious,
                                    tooltip: 'Previous',
                                    icon: Icon(
                                      Icons.skip_previous_rounded,
                                      size: 38,
                                      color: warna.onSurface,
                                    ),
                                  ),

                                  const SizedBox(width: 22),

                                  // Tombol utama Play/Pause
                                  SizedBox(
                                    width: 68,
                                    height: 68,
                                    child: IconButton(
                                      onPressed: isLoadingAudio
                                          ? null
                                          : onPlayPause,
                                      style: IconButton.styleFrom(
                                        backgroundColor: warna.primary,
                                        foregroundColor: Colors.white,
                                      ),
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 38,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 22),

                                  IconButton(
                                    onPressed: onNext,
                                    tooltip: 'Next',
                                    icon: Icon(
                                      Icons.skip_next_rounded,
                                      size: 38,
                                      color: warna.onSurface,
                                    ),
                                  ),
                                ],
                              ),

                              if (isLoadingAudio) ...[
                                const SizedBox(height: 12),
                                const CircularProgressIndicator(),
                              ] else ...[
                                const SizedBox(height: 8),
                                Text(
                                  isPlaying
                                      ? 'Now playing'
                                      : 'Playback paused',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warna.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// Model sederhana untuk menyimpan satu baris lirik
class BarisLirik {
  final Duration waktu;
  final String teks;

  BarisLirik({
    required this.waktu,
    required this.teks,
  });
}

class NowPlayingPage extends StatefulWidget {
  final AudioPlayer player;
  final Map<String, dynamic>? currentSong;
  final bool isLoadingAudio;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPlayPause;

  // Data lirik dari LRCLIB
  final Map<String, dynamic>? lyrics;
  final bool isLoadingLyrics;

  const NowPlayingPage({
    super.key,
    required this.player,
    required this.currentSong,
    required this.isLoadingAudio,
    required this.onPrevious,
    required this.onNext,
    required this.onPlayPause,
    required this.lyrics,
    required this.isLoadingLyrics,
  });

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  // Mengatur tampilan lirik
  bool tampilkanLirik = false;

  // Mengubah format LRC menjadi daftar baris lirik
  List<BarisLirik> parseLirik(String lrc) {
    final List<BarisLirik> hasil = [];

    final lines = lrc.split('\n');

    // Format waktu LRC: [menit:detik.milidetik]
    final pola = RegExp(
      r'\[(\d{2}):(\d{2})(?:\.(\d{1,3}))?\]',
    );

    for (final line in lines) {
      final matches = pola.allMatches(line).toList();

      if (matches.isEmpty) continue;

      // Mengambil teks setelah timestamp terakhir
      final teks = line.replaceAll(pola, '').trim();

      if (teks.isEmpty) continue;

      // Satu baris dapat memiliki beberapa timestamp
      for (final match in matches) {
        final menit = int.parse(match.group(1)!);
        final detik = int.parse(match.group(2)!);

        final pecahan = match.group(3) ?? '0';

        // Mengubah pecahan detik menjadi milidetik
        final milidetik = int.parse(
          pecahan.padRight(3, '0'),
        );

        final waktu = Duration(
          minutes: menit,
          seconds: detik,
          milliseconds: milidetik,
        );

        hasil.add(
          BarisLirik(
            waktu: waktu,
            teks: teks,
          ),
        );
      }
    }

    // Mengurutkan lirik berdasarkan timestamp
    hasil.sort(
          (a, b) => a.waktu.compareTo(b.waktu),
    );

    return hasil;
  }

  // Mencari indeks baris lirik sesuai posisi audio
  int cariBarisAktif(
      List<BarisLirik> daftar,
      Duration posisi,
      ) {
    int indeksAktif = -1;

    for (int i = 0; i < daftar.length; i++) {
      if (posisi >= daftar[i].waktu) {
        indeksAktif = i;
      } else {
        break;
      }
    }

    return indeksAktif;
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    if (widget.currentSong == null) {
      return Center(
        child: Text(
          'Choose a song first.',
          style: TextStyle(
            color: warna.onSurfaceVariant,
          ),
        ),
      );
    }

    final double artworkSize =
    MediaQuery.of(context).size.width < 500 ? 260 : 320;

    final syncedLyrics =
        widget.lyrics?['syncedLyrics']?.toString() ?? '';

    final plainLyrics =
        widget.lyrics?['plainLyrics']?.toString() ?? '';

    final bool instrumental =
        widget.lyrics?['instrumental'] == true;

    final bool memilikiLirikSinkron =
        syncedLyrics.trim().isNotEmpty;

    final bool memilikiLirikBiasa =
        plainLyrics.trim().isNotEmpty;

    // Mengutamakan lirik yang memiliki timestamp
    final List<BarisLirik> daftarLirik =
    memilikiLirikSinkron
        ? parseLirik(syncedLyrics)
        : [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
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

          const SizedBox(height: 28),

          // Ini bagian cover lagu
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.currentSong!['artworkUrl100'] ?? '',
              width: artworkSize,
              height: artworkSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
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

          const SizedBox(height: 25),

          Text(
            widget.currentSong!['trackName'] ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            widget.currentSong!['artistName'] ?? '-',
            style: TextStyle(
              color: warna.onSurfaceVariant,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),

          // Ini bagian progress dan durasi audio
          StreamBuilder<Duration?>(
            stream: widget.player.durationStream,
            builder: (context, durationSnapshot) {
              final duration =
                  durationSnapshot.data ?? Duration.zero;

              final maxValue =
              duration.inMilliseconds > 0
                  ? duration.inMilliseconds.toDouble()
                  : 1.0;

              return StreamBuilder<Duration>(
                stream: widget.player.positionStream,
                builder: (context, positionSnapshot) {
                  final position =
                      positionSnapshot.data ?? Duration.zero;

                  final currentValue = position.inMilliseconds
                      .toDouble()
                      .clamp(0.0, maxValue)
                      .toDouble();

                  return Column(
                    children: [
                      Slider(
                        value: currentValue,
                        max: maxValue,
                        activeColor: warna.primary,
                        inactiveColor: warna.outline,
                        onChanged:
                        duration.inMilliseconds <= 0
                            ? null
                            : (value) {
                          widget.player.seek(
                            Duration(
                              milliseconds: value.toInt(),
                            ),
                          );
                        },
                      ),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDurasi(position),
                            style: TextStyle(
                              color: warna.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),

                          Text(
                            formatDurasi(duration),
                            style: TextStyle(
                              color: warna.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 12),

          // Ini bagian kontrol musik
          StreamBuilder<PlayerState>(
            stream: widget.player.playerStateStream,
            builder: (context, snapshot) {
              final playing =
                  snapshot.data?.playing ?? false;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: widget.onPrevious,
                    icon: Icon(
                      Icons.skip_previous,
                      color: warna.onSurface,
                      size: 35,
                    ),
                  ),

                  const SizedBox(width: 20),

                  IconButton(
                    onPressed:
                    widget.isLoadingAudio
                        ? null
                        : widget.onPlayPause,
                    icon: Icon(
                      playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: warna.primary,
                      size: 65,
                    ),
                  ),

                  const SizedBox(width: 20),

                  IconButton(
                    onPressed: widget.onNext,
                    icon: Icon(
                      Icons.skip_next,
                      color: warna.onSurface,
                      size: 35,
                    ),
                  ),
                ],
              );
            },
          ),

          if (widget.isLoadingAudio)
            const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ),

          const SizedBox(height: 20),

          // Tombol untuk membuka dan menutup lirik
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                tampilkanLirik = !tampilkanLirik;
              });
            },
            icon: Icon(
              tampilkanLirik
                  ? Icons.keyboard_arrow_up
                  : Icons.lyrics_outlined,
            ),
            label: Text(
              tampilkanLirik
                  ? 'Hide Lyrics'
                  : 'View Lyrics',
            ),
          ),

          // Panel lirik
          if (tampilkanLirik) ...[
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: warna.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: warna.outline,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'LYRICS',
                    style: TextStyle(
                      color: warna.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (widget.isLoadingLyrics)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text('Finding lyrics...'),
                        ],
                      ),
                    )

                  else if (instrumental)
                    Text(
                      'This track is instrumental.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: warna.onSurfaceVariant,
                      ),
                    )

                  else if (memilikiLirikSinkron &&
                        daftarLirik.isNotEmpty)
                      StreamBuilder<Duration>(
                        stream: widget.player.positionStream,
                        builder: (context, snapshot) {
                          final posisi =
                              snapshot.data ?? Duration.zero;

                          final indeksAktif = cariBarisAktif(
                            daftarLirik,
                            posisi,
                          );

                          return Column(
                            children: List.generate(
                              daftarLirik.length,
                                  (index) {
                                final baris = daftarLirik[index];

                                final bool aktif =
                                    index == indeksAktif;

                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    vertical: 9,
                                  ),
                                  child: AnimatedDefaultTextStyle(
                                    duration:
                                    const Duration(
                                      milliseconds: 200,
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                      aktif ? 19 : 15,
                                      height: 1.5,
                                      fontWeight:
                                      aktif
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color:
                                      aktif
                                          ? warna.primary
                                          : warna.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                    child: Text(baris.teks),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )

                    else if (memilikiLirikBiasa)
                        Text(
                          plainLyrics,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: warna.onSurface,
                            fontSize: 15,
                            height: 1.8,
                          ),
                        )

                      else
                        Text(
                          'Lyrics are not available for this song.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: warna.onSurfaceVariant,
                          ),
                        ),

                  const SizedBox(height: 18),

                  Text(
                    'Lyrics provided by LRCLIB',
                    style: TextStyle(
                      color: warna.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Ini bagian untuk mengubah durasi menjadi menit dan detik
  String formatDurasi(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

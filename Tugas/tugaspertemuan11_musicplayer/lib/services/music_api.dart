
import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicApi {
  // Ini bagian untuk mencari lagu melalui iTunes API
  Future<List<dynamic>> cariLagu(String keyword) async {
    final url = Uri.https(
      'itunes.apple.com',
      '/search',
      <String, String>{
        'term': keyword,
        'limit': '20',
        'entity': 'song',
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Gagal mengambil data lagu');
    }
  }

  // Ini bagian untuk mengambil lirik lagu melalui LRCLIB
  Future<Map<String, dynamic>?> cariLirik(
      Map<String, dynamic> song,
      ) async {
    final judul = song['trackName']?.toString() ?? '';
    final artis = song['artistName']?.toString() ?? '';
    final album = song['collectionName']?.toString() ?? '';

    // Mengambil durasi asli lagu dari iTunes
    final durasiMillis =
        (song['trackTimeMillis'] as num?)?.toInt() ?? 0;

    final durasiDetik = (durasiMillis / 1000).round();

    if (judul.isEmpty || artis.isEmpty) {
      return null;
    }

    // Menyiapkan parameter pencarian lirik
    final parameter = <String, String>{
      'track_name': judul,
      'artist_name': artis,
    };

    if (album.isNotEmpty) {
      parameter['album_name'] = album;
    }

    if (durasiDetik > 0) {
      parameter['duration'] = durasiDetik.toString();
    }

    // Mencoba mencari kecocokan lagu secara langsung
    final url = Uri.https(
      'lrclib.net',
      '/api/get',
      parameter,
    );

    final response = await http.get(
      url,
      headers: {
        'X-User-Agent': 'Ivylodia Music Player/1.0',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return data;
      }
    }

    // Jika tidak ditemukan, mencoba pencarian alternatif
    if (response.statusCode == 404) {
      final searchUrl = Uri.https(
        'lrclib.net',
        '/api/search',
        {
          'track_name': judul,
          'artist_name': artis,
        },
      );

      final searchResponse = await http.get(
        searchUrl,
        headers: {
          'X-User-Agent': 'Ivylodia Music Player/1.0',
        },
      );

      if (searchResponse.statusCode == 200) {
        final hasil = jsonDecode(searchResponse.body);

        if (hasil is List) {
          // Memilih hasil yang judul dan artisnya cocok
          for (final item in hasil) {
            if (item is! Map<String, dynamic>) continue;

            final judulHasil =
                item['trackName']?.toString().toLowerCase() ?? '';

            final artisHasil =
                item['artistName']?.toString().toLowerCase() ?? '';

            if (judulHasil == judul.toLowerCase() &&
                artisHasil == artis.toLowerCase()) {
              return item;
            }
          }
        }
      }
    }

    if (response.statusCode == 429) {
      throw Exception('Terlalu banyak permintaan lirik. Coba lagi nanti.');
    }

    if (response.statusCode >= 500) {
      throw Exception('Server lirik sedang mengalami gangguan.');
    }

    return null;
  }
}

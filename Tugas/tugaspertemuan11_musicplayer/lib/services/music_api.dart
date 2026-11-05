
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

  // Menyamakan format teks untuk proses pencocokan
  String normalisasi(String teks) {
    return teks
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  // Memastikan hasil LRCLIB berasal dari rekaman yang sesuai
  bool cocokkanLirik(
      Map<String, dynamic> hasil,
      String judul,
      String artis,
      String album,
      int durasiDetik,
      ) {
    final judulHasil =
        hasil['trackName']?.toString() ?? '';

    final artisHasil =
        hasil['artistName']?.toString() ?? '';

    final albumHasil =
        hasil['albumName']?.toString() ?? '';

    final durasiHasil =
    (hasil['duration'] as num?)?.toDouble();

    // Judul dan artis harus cocok
    if (normalisasi(judulHasil) != normalisasi(judul)) {
      return false;
    }

    if (normalisasi(artisHasil) != normalisasi(artis)) {
      return false;
    }

    // Durasi harus berbeda maksimal 2 detik
    if (durasiHasil == null ||
        (durasiHasil - durasiDetik).abs() > 2) {
      return false;
    }

    // Album diperiksa jika kedua sumber menyediakan nama album
    if (album.isNotEmpty && albumHasil.isNotEmpty) {
      if (normalisasi(albumHasil) != normalisasi(album)) {
        return false;
      }
    }

    return true;
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

    if (judul.isEmpty ||
        artis.isEmpty ||
        durasiDetik <= 0) {
      return null;
    }

    // Menyiapkan parameter pencarian LRCLIB
    final parameter = <String, String>{
      'track_name': judul,
      'artist_name': artis,
      'duration': durasiDetik.toString(),
    };

    if (album.isNotEmpty) {
      parameter['album_name'] = album;
    }

    final headers = {
      'X-User-Agent': 'Ivylodia Music Player/1.0',
    };

    // Tahap pertama: mencari kecocokan berdasarkan signature lagu
    final url = Uri.https(
      'lrclib.net',
      '/api/get',
      parameter,
    );

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic> &&
          cocokkanLirik(
            data,
            judul,
            artis,
            album,
            durasiDetik,
          )) {
        return data;
      }
    }

    if (response.statusCode == 429) {
      throw Exception(
        'Terlalu banyak permintaan lirik. Coba lagi nanti.',
      );
    }

    if (response.statusCode >= 500) {
      throw Exception(
        'Server lirik sedang mengalami gangguan.',
      );
    }

    // Tahap kedua: pencarian alternatif
    // Hasil tetap harus melewati pemeriksaan kecocokan
    if (response.statusCode == 404 ||
        response.statusCode == 200) {
      final searchUrl = Uri.https(
        'lrclib.net',
        '/api/search',
        {
          'track_name': judul,
          'artist_name': artis,
          if (album.isNotEmpty) 'album_name': album,
        },
      );

      final searchResponse = await http.get(
        searchUrl,
        headers: headers,
      );

      if (searchResponse.statusCode == 429) {
        throw Exception(
          'Terlalu banyak permintaan lirik. Coba lagi nanti.',
        );
      }

      if (searchResponse.statusCode >= 500) {
        throw Exception(
          'Server lirik sedang mengalami gangguan.',
        );
      }

      if (searchResponse.statusCode == 200) {
        final hasil = jsonDecode(searchResponse.body);

        if (hasil is List) {
          for (final item in hasil) {
            if (item is! Map<String, dynamic>) continue;

            if (cocokkanLirik(
              item,
              judul,
              artis,
              album,
              durasiDetik,
            )) {
              return item;
            }
          }
        }
      }
    }

    // Tidak menemukan rekaman yang cukup cocok
    return null;
  }
}
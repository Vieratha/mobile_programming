import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicApi {
  //Ini bagian untuk mencari lagu melalui iTunes API
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
}

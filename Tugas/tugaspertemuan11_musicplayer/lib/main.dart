import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  List songs = [];

  Future<void> cariLagu() async {
    final url = Uri.https('itunes.apple.com',
        '/search',
      <String, String>{
        'term': controller.text,
        'limit': '10',
        'entity': 'song',
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        songs = data['results'];
      });
    } else {
      setState(() {
        songs = [];
      });
    }
    debugPrint('HTTP Error: ${response.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player'),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Judul lagu atau artis'),
            ),
            ElevatedButton(
                onPressed: cariLagu,
                child: Text('Cari Lagu')
            ),
            Expanded(child:
            ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index)
                {
                  return ListTile(
                    title: Text(songs[index]['trackName'] ?? '-'),
                    subtitle: Text(songs[index]['artistName'] ?? '-'),
                  );
                },
                ),
            ),
          ],
        ),
      ),
    );
  }
}
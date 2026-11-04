import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

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

          const SizedBox(height: 20),
          Icon(
            Icons.library_music_outlined,
            size: 55,
            color: warna.onSurfaceVariant,
          ),

          const SizedBox(height: 12),
          Text(
            'Your music collection will appear here.',
            style: TextStyle(
              color: warna.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
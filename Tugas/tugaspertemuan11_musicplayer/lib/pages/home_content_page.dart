import 'package:flutter/material.dart';

class HomeContentPage extends StatelessWidget {
  final VoidCallback onExplore;

  const HomeContentPage({
    super.key,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good music, good mood.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 8),
          Text(
            'Your music, your moment.',
            style: TextStyle(
              fontSize: 15,
              color: warna.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 30),
          Text(
            'Discover music',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              kategoriCard(context, 'Pop', Icons.music_note),
              kategoriCard(context, 'R&B', Icons.graphic_eq),
              kategoriCard(context, 'Indie', Icons.album_outlined),
            ],
          ),

          const SizedBox(height: 35),
          Text(
            'Start listening',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: warna.surface,
              borderRadius: BorderRadius.circular(14),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.headphones,
                  size: 35,
                  color: warna.primary,
                ),

                const SizedBox(height: 14),
                Text(
                  'Find your next favorite song.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: warna.onSurface,
                  ),
                ),

                const SizedBox(height: 7),
                Text(
                  'Search for songs and artists to start exploring.',
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: onExplore,
                  child: const Text('Explore music'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian untuk membuat kartu kategori
  Widget kategoriCard(
      BuildContext context,
      String title,
      IconData icon,
      ) {
    final warna = Theme.of(context).colorScheme;

    return Container(
      width: 145,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: warna.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna.outline),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: warna.primary,
            size: 27,
          ),

          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
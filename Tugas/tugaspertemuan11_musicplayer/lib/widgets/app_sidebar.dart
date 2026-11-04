import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final int selectedMenu;
  final Function(int) onMenuSelected;

  const AppSidebar({
    super.key,
    required this.selectedMenu,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Container(
      width: 230,
      color: warna.surface,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ivylodia',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE83D70),
            ),
          ),

          const SizedBox(height: 40),

          Text(
            'MENU',
            style: TextStyle(
              color: warna.onSurfaceVariant,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 15),
          menuItem(context, Icons.home_outlined, 'Home', 0),
          menuItem(context, Icons.search, 'Search', 1),
          menuItem(context, Icons.library_music_outlined, 'Your Library', 2),

          const Spacer(),
          const Divider(),
          Text(
            'IVYLODIA MUSIC',
            style: TextStyle(
              color: warna.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Ini bagian untuk membuat item navigasi
  Widget menuItem(
      BuildContext context,
      IconData icon,
      String title,
      int index,
      ) {
    final warna = Theme.of(context).colorScheme;
    final bool active = selectedMenu == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        selected: active,
        selectedTileColor: warna.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        leading: Icon(
          icon,
          color: active ? warna.primary : warna.onSurfaceVariant,
        ),

        title: Text(
          title,
          style: TextStyle(
            color: active ? warna.primary : warna.onSurface,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => onMenuSelected(index),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onProfileTap;
  final IconData avatarIcon;

  const AppHeader({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onProfileTap,
    required this.avatarIcon,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final bool isMobile = MediaQuery.of(context).size.width < 850;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      child: Row(
        children: [
          if (isMobile) ...[
            Text(
              'Ivylodia',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: warna.primary,
              ),
            ),
            const SizedBox(width: 18),
          ],

          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: warna.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: warna.outline),
              ),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSearch(),
                decoration: InputDecoration(
                  hintText: 'Search songs, artists...',
                  hintStyle: TextStyle(color: warna.onSurfaceVariant),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: onSearch,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          const SizedBox(width: 18),

          // Avatar mengikuti pilihan pengguna
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(30),
            child: CircleAvatar(
              backgroundColor: warna.secondaryContainer,
              child: Icon(avatarIcon, color: warna.primary),
            ),
          ),
        ],
      ),
    );
  }
}

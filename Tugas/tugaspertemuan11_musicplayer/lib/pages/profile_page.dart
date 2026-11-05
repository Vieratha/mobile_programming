
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controller untuk mengelola data profil
  final TextEditingController namaController =
  TextEditingController(text: 'Indra Kurniawan');

  final TextEditingController emailController =
  TextEditingController(text: 'vietha@gmail.com');

  final TextEditingController bioController =
  TextEditingController(
    text: 'Music is part of my everyday life.',
  );

  // Menyimpan data profil
  String namaAwal = 'Indra Kurniawan';
  String emailAwal = 'vietha@gmail.com';
  String bioAwal = 'Music is part of my everyday life.';

  // Mengatur avatar profil
  IconData avatarIcon = Icons.person;

  // Menentukan apakah profil sedang diedit
  bool isEditing = false;

  // Mengaktifkan mode edit profil
  void mulaiEdit() {
    setState(() {
      isEditing = true;
    });
  }

  // Menyimpan perubahan data profil
  void simpanProfil() {
    if (namaController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name and email cannot be empty.'),
        ),
      );
      return;
    }

    setState(() {
      namaAwal = namaController.text.trim();
      emailAwal = emailController.text.trim();
      bioAwal = bioController.text.trim();

      isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
      ),
    );
  }

  // Membatalkan perubahan dan mengembalikan data sebelumnya
  void batalEdit() {
    setState(() {
      namaController.text = namaAwal;
      emailController.text = emailAwal;
      bioController.text = bioAwal;

      isEditing = false;
    });
  }

  // Menampilkan pilihan avatar
  void pilihAvatar() {
    final warna = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Avatar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: warna.onSurface,
                  ),
                ),

                const SizedBox(height: 16),

                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    avatarOption(Icons.person, 'Default'),
                    avatarOption(Icons.face, 'Avatar 1'),
                    avatarOption(Icons.face_3, 'Avatar 2'),
                    avatarOption(Icons.face_4, 'Avatar 3'),
                    avatarOption(Icons.face_6, 'Avatar 4'),
                    avatarOption(Icons.music_note, 'Music'),
                    avatarOption(Icons.headphones, 'Headphones'),
                    avatarOption(Icons.star, 'Star'),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  // Membuat pilihan avatar
  Widget avatarOption(IconData icon, String label) {
    final warna = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        setState(() {
          avatarIcon = icon;
        });

        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 75,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: avatarIcon == icon
              ? warna.secondaryContainer
              : warna.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: avatarIcon == icon
                ? warna.primary
                : warna.outline,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: warna.primary,
            ),

            const SizedBox(height: 6),

            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: warna.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul halaman profil
          Text(
            'My Profile',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: warna.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Manage your personal information.',
            style: TextStyle(
              color: warna.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 35),

          // Avatar dan informasi singkat pengguna
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: warna.secondaryContainer,
                      child: Icon(
                        avatarIcon,
                        size: 55,
                        color: warna.primary,
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Material(
                        color: warna.primary,
                        shape: const CircleBorder(),
                        child: IconButton(
                          onPressed: pilihAvatar,
                          tooltip: 'Change Avatar',
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Text(
                  namaAwal,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: warna.onSurface,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  emailAwal,
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          // Informasi pribadi pengguna
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: warna.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: warna.outline,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: warna.onSurface,
                  ),
                ),

                const SizedBox(height: 22),

                // Input nama pengguna
                Text(
                  'Display Name',
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: namaController,
                  enabled: isEditing,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                // Input alamat email
                Text(
                  'Email Address',
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  enabled: isEditing,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                // Input deskripsi singkat pengguna
                Text(
                  'About Me',
                  style: TextStyle(
                    color: warna.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: bioController,
                  enabled: isEditing,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.edit_note),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 25),

                // Tombol sesuai mode profil
                if (!isEditing)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: mulaiEdit,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: simpanProfil,
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: OutlinedButton(
                          onPressed: batalEdit,
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Center(
            child: Text(
              'Made with music and love.',
              style: TextStyle(
                color: warna.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
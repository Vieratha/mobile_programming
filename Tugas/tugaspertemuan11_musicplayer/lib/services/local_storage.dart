import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String keyNama = 'profile_nama';
  static const String keyEmail = 'profile_email';
  static const String keyBio = 'profile_bio';
  static const String keyAvatar = 'profile_avatar';
  static const String keyFavorites = 'favorite_songs';

  // Daftar avatar yang tersedia di aplikasi.
  static const Map<String, IconData> daftarAvatar = {
    'default': Icons.person,
    'avatar1': Icons.face,
    'avatar2': Icons.face_3,
    'avatar3': Icons.face_4,
    'avatar4': Icons.face_6,
    'music': Icons.music_note,
    'headphones': Icons.headphones,
    'star': Icons.star,
  };

  // Mengambil ID avatar berdasarkan IconData.
  static String idAvatar(IconData avatar) {
    for (final item in daftarAvatar.entries) {
      if (item.value == avatar) {
        return item.key;
      }
    }

    return 'default';
  }

  // Mengambil IconData berdasarkan ID avatar.
  static IconData iconAvatar(String id) {
    return daftarAvatar[id] ?? Icons.person;
  }

  // Menyimpan data profil pengguna.
  static Future<void> simpanProfil({
    required String nama,
    required String email,
    required String bio,
    required IconData avatar,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(keyNama, nama);
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyBio, bio);
    await prefs.setString(keyAvatar, idAvatar(avatar));
  }

  // Mengambil data profil pengguna.
  static Future<Map<String, dynamic>> ambilProfil() async {
    final prefs = await SharedPreferences.getInstance();

    final String id = prefs.getString(keyAvatar) ?? 'default';

    return {
      'nama': prefs.getString(keyNama) ?? 'Indra Kurniawan',
      'email': prefs.getString(keyEmail) ?? 'vietha@gmail.com',
      'bio': prefs.getString(keyBio) ?? 'Music is part of my everyday life.',
      'avatar': iconAvatar(id),
    };
  }

  // Menyimpan daftar lagu favorit dalam format JSON.
  static Future<void> simpanFavorite(List<Map<String, dynamic>> songs) async {
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode(songs);

    await prefs.setString(keyFavorites, data);
  }

  // Mengambil daftar lagu favorit.
  static Future<List<Map<String, dynamic>>> ambilFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString(keyFavorites);

    if (data == null || data.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> hasil = jsonDecode(data);

      return hasil.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}

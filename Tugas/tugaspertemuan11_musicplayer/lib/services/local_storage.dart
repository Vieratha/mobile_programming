import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Nama key untuk setiap data yang disimpan.
  static const String keyNama = 'profile_nama';
  static const String keyEmail = 'profile_email';
  static const String keyBio = 'profile_bio';
  static const String keyAvatar = 'profile_avatar';
  static const String keyFavorites = 'favorite_songs';

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
    await prefs.setInt(keyAvatar, avatar.codePoint);
  }

  // Mengambil data profil pengguna.
  static Future<Map<String, dynamic>> ambilProfil() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'nama': prefs.getString(keyNama) ?? 'Indra Kurniawan',
      'email': prefs.getString(keyEmail) ?? 'vietha@gmail.com',
      'bio': prefs.getString(keyBio) ??
          'Music is part of my everyday life.',
      'avatar': IconData(
        prefs.getInt(keyAvatar) ?? Icons.person.codePoint,
        fontFamily: 'MaterialIcons',
      ),
    };
  }

  // Menyimpan daftar lagu favorit sebagai JSON.
  static Future<void> simpanFavorite(
      List<Map<String, dynamic>> songs,
      ) async {
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
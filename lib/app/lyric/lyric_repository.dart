import 'dart:convert';

import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LyricRepository {
  Future<List<Lyric>> loadFrenchLyrics() async {
    try {
      final response = await rootBundle.loadString('assets/fr.json');
      final json = jsonDecode(response);
      return (json['songs'] as List).map((e) => Lyric.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load French lyrics: $e');
    }
  }

  Future<List<Lyric>> loadEnglishLyrics() async {
    try {
      final response = await rootBundle.loadString('assets/en.json');
      final json = jsonDecode(response);
      return (json['songs'] as List).map((e) => Lyric.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load English lyrics: $e');
    }
  }
}

final lyricRepositoryProvider = Provider<LyricRepository>(
  (ref) => LyricRepository(),
);

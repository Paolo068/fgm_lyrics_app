import 'dart:convert';

import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;

final lyricRepositoryProvider = Provider<LyricRepository>((ref) {
  return LyricRepository();
});

class LyricRepository {
  Future<List<Lyric>> loadFrenchLyrics() async {
    final response = await rootBundle.loadString('assets/FR.json');
    final json = jsonDecode(response);
    return (json['songs'] as List).map((e) => Lyric.fromMap(e)).toList();
  }

  Future<List<Lyric>> loadEnglishLyrics() async {
    final response = await rootBundle.loadString('assets/EN.json');
    final json = jsonDecode(response);
    return (json['songs'] as List).map((e) => Lyric.fromMap(e)).toList();
  }
}

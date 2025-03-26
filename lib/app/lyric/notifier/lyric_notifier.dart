import 'package:fgm_lyrics_app/app/lyric/lyric_repository.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show FutureProvider;

final frenchLyricProvider = FutureProvider<List<Lyric>>((ref) async {
  final lyrics = await ref.read(lyricRepositoryProvider).loadFrenchLyrics();
  return lyrics;
});

final englishLyricProvider = FutureProvider<List<Lyric>>((ref) async {
  final lyrics = await ref.read(lyricRepositoryProvider).loadEnglishLyrics();
  return lyrics;
});

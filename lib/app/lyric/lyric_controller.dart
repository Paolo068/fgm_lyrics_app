import 'package:fgm_lyrics_app/app/lyric/lyric_repository.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final frenchLyricProvider = FutureProvider<List<Lyric>>((ref) async {
  final lyricRepository = ref.watch(lyricRepositoryProvider);
  return lyricRepository.loadFrenchLyrics();
});

final englishLyricProvider = FutureProvider<List<Lyric>>((ref) async {
  final lyricRepository = ref.watch(lyricRepositoryProvider);
  return lyricRepository.loadEnglishLyrics();
});

import 'dart:async';

import 'package:fgm_lyrics_app/app/lyric/lyric_repository.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FrenchHymn extends AsyncNotifier<List<Lyric>> {
  @override
  FutureOr<List<Lyric>> build() {
    _loadFrenchLyrics();
    return [];
  }

  Future<void> _loadFrenchLyrics() async {
    state = const AsyncValue.loading();
    final lyrics = await ref.read(lyricRepositoryProvider).loadFrenchLyrics();
    state = AsyncValue.data(lyrics);
  }
}

final frenchHymnProvider = AsyncNotifierProvider<FrenchHymn, List<Lyric>>(
  () => FrenchHymn(),
);

class EnglishHymn extends AsyncNotifier<List<Lyric>> {
  @override
  FutureOr<List<Lyric>> build() {
    _loadEnglishLyrics();
    return [];
  }

  Future<void> _loadEnglishLyrics() async {
    state = const AsyncValue.loading();
    final lyrics = await ref.read(lyricRepositoryProvider).loadEnglishLyrics();
    state = AsyncValue.data(lyrics);
  }
}

final englishHymnProvider = AsyncNotifierProvider<EnglishHymn, List<Lyric>>(
  () => EnglishHymn(),
);

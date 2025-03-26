import 'package:fgm_lyrics_app/core/shared/app_default_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../notifier/lyric_notifier.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lyricState = ref.watch(frenchLyricProvider);
    return Scaffold(
      body: AppDefaultSpacing(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final lyric = lyricState.requireValue[index];
            return ListTile(
              leading: Text(lyric.id.toString()),
              title: Text(lyric.songTitle),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemCount: lyricState.requireValue.length,
        ),
      ),
    );
  }
}

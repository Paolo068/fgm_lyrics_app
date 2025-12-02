import 'package:fgm_lyrics_app/app/locale/locale_provider.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:fgm_lyrics_app/core/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LyricTitle extends ConsumerWidget {
  const LyricTitle({super.key, required this.lyric});

  final Lyric lyric;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageIsEnglish =
        ref.watch(deviceLocaleProvider) == LanguageEnum.en.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${lyric.id}.  ${lyric.songTitle.capitalize}'),
        DefaultTextStyle(
          style: context.textTheme.bodyMedium!.copyWith(
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lyric.author.isNotEmpty
                  ? Text(
                      '${languageIsEnglish ? 'Author: ' : 'Auteur: '} ${lyric.author}',
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 3),
              lyric.key.isNotEmpty
                  ? Text(
                      '${languageIsEnglish ? 'Key: ' : 'Clef: '} ${lyric.key}',
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

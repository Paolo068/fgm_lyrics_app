import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:fgm_lyrics_app/core/utils/string_extension.dart';
import 'package:flutter/material.dart';

class LyricTitle extends StatelessWidget {
  const LyricTitle({super.key, required this.lyric, required this.isEnglish});

  final Lyric lyric;
  final bool isEnglish;
  @override
  Widget build(BuildContext context) {
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
                    '${isEnglish ? 'Author: ' : 'Auteur: '} ${lyric.author}',
                  )
                  : const SizedBox.shrink(),
              const SizedBox(height: 3),
              lyric.key.isNotEmpty
                  ? Text('${isEnglish ? 'Key: ' : 'Clef: '} ${lyric.key}')
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class LyricVerses extends StatelessWidget {
  const LyricVerses({super.key, required this.enLyrics});

  final List<String> enLyrics;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children:
          enLyrics.length > 1
              ? enLyrics
                  .sublist(1, enLyrics.length - 1)
                  .map(
                    (lyric) => Center(
                      child: Text(
                        '$lyric\n',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  )
                  .toList()
              : [],
    );
  }
}

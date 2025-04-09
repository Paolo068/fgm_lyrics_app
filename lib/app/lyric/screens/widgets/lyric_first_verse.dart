import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class LyricFirstVerse extends StatelessWidget {
  const LyricFirstVerse({super.key, required this.enLyrics});

  final List<String> enLyrics;

  @override
  Widget build(BuildContext context) {
    return Text(
      enLyrics.first,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyLarge,
    );
  }
}

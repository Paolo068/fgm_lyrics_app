import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class LyricChorus extends StatelessWidget {
  const LyricChorus({super.key, required this.chorus});

  final String chorus;

  @override
  Widget build(BuildContext context) {
    return Text(
      chorus,
      textAlign: TextAlign.center,
      style: context.textTheme.titleLarge!.copyWith(
        fontStyle: FontStyle.italic,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

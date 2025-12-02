import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class AppHeadlineText extends StatelessWidget {
  final String text;
  const AppHeadlineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
        color: Theme.of(
          context,
        ).textTheme.headlineSmall!.color?.withValues(alpha: .7),
      ),
    );
  }
}

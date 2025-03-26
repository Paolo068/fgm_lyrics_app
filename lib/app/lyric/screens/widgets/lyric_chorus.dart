import 'package:flutter/material.dart';

class LyricChorus extends StatelessWidget {
  const LyricChorus({super.key, required this.chorus});

  final String chorus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          chorus,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

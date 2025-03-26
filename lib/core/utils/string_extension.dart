extension StringExtension on String {
  String get capitalizeWord => "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  String get minimizeWord => toLowerCase();

  String get capitalize {
    final RegExp keyWords = RegExp(
        r'\b(?:Jesus|Lord|Jésus|Sauveur|Seigneur|Savior|Saviour|God|Dieu|Thee|Thou|Thy|I|Him|Son|His)\b',
        caseSensitive: false);
    final firstWord = split(" ").first.capitalizeWord;

    final remainingWords = split(' ')
        .sublist(1)
        .map((wordInSentence) => wordInSentence.toLowerCase().contains(keyWords)
            ? wordInSentence.capitalizeWord
            : wordInSentence.minimizeWord)
        .join(' ');

    return "$firstWord $remainingWords";
  }
}

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

   // Navigator extension
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}

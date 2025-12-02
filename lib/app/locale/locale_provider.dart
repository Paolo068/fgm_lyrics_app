import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LanguageEnum { en, fr }

final deviceLocaleProvider = NotifierProvider<DeviceLocaleNotifier, String>(
  DeviceLocaleNotifier.new,
);

class DeviceLocaleNotifier extends Notifier<String> {
  @override
  String build() => PlatformDispatcher.instance.locale.languageCode;
  void changeLocale() {
    state = state == LanguageEnum.en.name
        ? LanguageEnum.fr.name
        : LanguageEnum.en.name;
    debugPrint('locale: $state');
  }
}

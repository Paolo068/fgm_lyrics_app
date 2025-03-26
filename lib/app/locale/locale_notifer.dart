import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Notifier, NotifierProvider;

final deviceLocaleProvider = NotifierProvider<DeviceLocaleNotifier, String>(
  DeviceLocaleNotifier.new,
);

class DeviceLocaleNotifier extends Notifier<String> {
  @override
  String build() {
    return PlatformDispatcher.instance.locale.languageCode;
  }

  setLocale(String locale) {
    state = locale;
  }
}

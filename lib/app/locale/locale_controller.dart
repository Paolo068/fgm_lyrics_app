import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceLocaleProvider = NotifierProvider<DeviceLocaleNotifier, String>(
  DeviceLocaleNotifier.new,
);

class DeviceLocaleNotifier extends Notifier<String> {
  @override
  String build() => PlatformDispatcher.instance.locale.languageCode;
  
  void setLocale(String locale) => state = locale;
}

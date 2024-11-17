// lib/utils/password_visibility_notifier.dart
import 'package:flutter/foundation.dart';

class PasswordVisibilityNotifier extends ValueNotifier<bool> {
  PasswordVisibilityNotifier(bool value) : super(value);

  void toggle() {
    value = !value;
  }
}

import 'package:flutter/material.dart';
import 'package:core_kit/src/ui/theme/app_semantic_colors.dart';

extension BuildContextThemeX on BuildContext {
  /// Mendapatkan keseluruhan ThemeData
  ThemeData get theme => Theme.of(this);

  /// Shortcut untuk TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Shortcut untuk ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Shortcut untuk custom semantic colors dari core_kit
  AppSemanticColors? get semanticColors => Theme.of(this).extension<AppSemanticColors>();
}

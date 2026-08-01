import 'package:flutter/material.dart';

/// Semantic colors (success / warning / info) that Material's [ColorScheme]
/// doesn't provide out of the box. Registered as a [ThemeExtension] in
/// [buildAppTheme] so any widget can read it via:
///
/// ```dart
/// final semantic = Theme.of(context).extension<AppSemanticColors>()!;
/// ```
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  final Color success;
  final Color successLight;
  final Color successDark;
  final Color onSuccess;

  final Color warning;
  final Color warningLight;
  final Color warningDark;
  final Color onWarning;

  final Color info;
  final Color infoLight;
  final Color infoDark;
  final Color onInfo;

  const AppSemanticColors({
    required this.success,
    required this.successLight,
    required this.successDark,
    required this.onSuccess,
    required this.warning,
    required this.warningLight,
    required this.warningDark,
    required this.onWarning,
    required this.info,
    required this.infoLight,
    required this.infoDark,
    required this.onInfo,
  });

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successLight,
    Color? successDark,
    Color? onSuccess,
    Color? warning,
    Color? warningLight,
    Color? warningDark,
    Color? onWarning,
    Color? info,
    Color? infoLight,
    Color? infoDark,
    Color? onInfo,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      successDark: successDark ?? this.successDark,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      warningDark: warningDark ?? this.warningDark,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      infoLight: infoLight ?? this.infoLight,
      infoDark: infoDark ?? this.infoDark,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successDark: Color.lerp(successDark, other.successDark, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      warningDark: Color.lerp(warningDark, other.warningDark, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
      infoDark: Color.lerp(infoDark, other.infoDark, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}

import 'package:flutter/material.dart';

/// Contract for an app's type scale.
///
/// [fontFamily] is left abstract since font choice is a brand decision.
/// The individual [TextStyle] getters describe sizes/weights/spacing only —
/// no color (color is applied later by [buildAppTheme] from [AppColorScheme]).
abstract class AppTypography {
  String get fontFamily;

  TextStyle get displayLarge;
  TextStyle get displayMedium;
  TextStyle get displaySmall;

  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;

  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleSmall;

  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;

  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;

  TextStyle get button;
  TextStyle get caption;
  TextStyle get overline;

  TextStyle get inputLabel;
  TextStyle get inputText;
  TextStyle get inputHint;
  TextStyle get inputError;
}

/// Default type scale. Apps can use this directly or `extends` it to
/// override just [fontFamily] (and any individual style) while keeping
/// the rest of the scale.
class DefaultTypography implements AppTypography {
  const DefaultTypography();

  @override
  String get fontFamily => 'Inter';

  @override
  TextStyle get displayLarge => const TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.2,
  );

  @override
  TextStyle get displayMedium => const TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.2,
  );

  @override
  TextStyle get displaySmall => const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.2,
  );

  @override
  TextStyle get headlineLarge => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.25,
  );

  @override
  TextStyle get headlineMedium => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  @override
  TextStyle get headlineSmall => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  @override
  TextStyle get titleLarge => const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  @override
  TextStyle get titleMedium => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  @override
  TextStyle get titleSmall => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  @override
  TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  @override
  TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  );

  @override
  TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.4,
  );

  @override
  TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  @override
  TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.3,
  );

  @override
  TextStyle get labelSmall => const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.3,
  );

  @override
  TextStyle get button => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  @override
  TextStyle get caption => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.3,
  );

  @override
  TextStyle get overline => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 1.6,
  );

  @override
  TextStyle get inputLabel => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    height: 1.3,
  );

  @override
  TextStyle get inputText => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  );

  @override
  TextStyle get inputHint => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  );

  @override
  TextStyle get inputError => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.3,
  );
}

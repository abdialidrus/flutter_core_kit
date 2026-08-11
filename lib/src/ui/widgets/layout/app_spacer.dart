import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Enum representing the standard spacing sizes available in the app.
/// These map directly to the values defined in [AppSpacing].
enum AppSpacerSize {
  xxs,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
}

/// Extension to get the actual double value from the [AppSpacerSize] enum.
extension AppSpacerSizeExtension on AppSpacerSize {
  double get value {
    switch (this) {
      case AppSpacerSize.xxs:
        return AppSpacing.xxs;
      case AppSpacerSize.xs:
        return AppSpacing.xs;
      case AppSpacerSize.sm:
        return AppSpacing.sm;
      case AppSpacerSize.md:
        return AppSpacing.md;
      case AppSpacerSize.lg:
        return AppSpacing.lg;
      case AppSpacerSize.xl:
        return AppSpacing.xl;
      case AppSpacerSize.xxl:
        return AppSpacing.xxl;
      case AppSpacerSize.xxxl:
        return AppSpacing.xxxl;
    }
  }
}

/// A wrapper around [SizedBox] to provide consistent vertical spacing.
///
/// Example:
/// ```dart
/// VSpace.md() // Creates a vertical space of 12.0
/// ```
class VSpace extends StatelessWidget {
  final AppSpacerSize size;

  const VSpace(this.size, {super.key});

  const VSpace.xxs({super.key}) : size = AppSpacerSize.xxs;
  const VSpace.xs({super.key}) : size = AppSpacerSize.xs;
  const VSpace.sm({super.key}) : size = AppSpacerSize.sm;
  const VSpace.md({super.key}) : size = AppSpacerSize.md;
  const VSpace.lg({super.key}) : size = AppSpacerSize.lg;
  const VSpace.xl({super.key}) : size = AppSpacerSize.xl;
  const VSpace.xxl({super.key}) : size = AppSpacerSize.xxl;
  const VSpace.xxxl({super.key}) : size = AppSpacerSize.xxxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size.value);
  }
}

/// A wrapper around [SizedBox] to provide consistent horizontal spacing.
///
/// Example:
/// ```dart
/// HSpace.md() // Creates a horizontal space of 12.0
/// ```
class HSpace extends StatelessWidget {
  final AppSpacerSize size;

  const HSpace(this.size, {super.key});

  const HSpace.xxs({super.key}) : size = AppSpacerSize.xxs;
  const HSpace.xs({super.key}) : size = AppSpacerSize.xs;
  const HSpace.sm({super.key}) : size = AppSpacerSize.sm;
  const HSpace.md({super.key}) : size = AppSpacerSize.md;
  const HSpace.lg({super.key}) : size = AppSpacerSize.lg;
  const HSpace.xl({super.key}) : size = AppSpacerSize.xl;
  const HSpace.xxl({super.key}) : size = AppSpacerSize.xxl;
  const HSpace.xxxl({super.key}) : size = AppSpacerSize.xxxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size.value);
  }
}

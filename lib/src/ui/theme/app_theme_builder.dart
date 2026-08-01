import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color_scheme.dart';
import 'app_semantic_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Assembles a complete [ThemeData] from an [AppColorScheme] and
/// [AppTypography]. Call once per brightness:
///
/// ```dart
/// final lightTheme = buildAppTheme(
///   brightness: Brightness.light,
///   colors: const TmsLightColors(),
///   typography: const DefaultTypography(),
/// );
/// final darkTheme = buildAppTheme(
///   brightness: Brightness.dark,
///   colors: const TmsDarkColors(),
///   typography: const DefaultTypography(),
/// );
/// ```
ThemeData buildAppTheme({
  required Brightness brightness,
  required AppColorScheme colors,
  required AppTypography typography,
}) {
  final textTheme = TextTheme(
    displayLarge: typography.displayLarge.copyWith(color: colors.textPrimary),
    displayMedium: typography.displayMedium.copyWith(color: colors.textPrimary),
    displaySmall: typography.displaySmall.copyWith(color: colors.textPrimary),
    headlineLarge: typography.headlineLarge.copyWith(color: colors.textPrimary),
    headlineMedium: typography.headlineMedium.copyWith(
      color: colors.textPrimary,
    ),
    headlineSmall: typography.headlineSmall.copyWith(color: colors.textPrimary),
    titleLarge: typography.titleLarge.copyWith(color: colors.textPrimary),
    titleMedium: typography.titleMedium.copyWith(color: colors.textPrimary),
    titleSmall: typography.titleSmall.copyWith(color: colors.textPrimary),
    bodyLarge: typography.bodyLarge.copyWith(color: colors.textPrimary),
    bodyMedium: typography.bodyMedium.copyWith(color: colors.textSecondary),
    bodySmall: typography.bodySmall.copyWith(color: colors.textTertiary),
    labelLarge: typography.labelLarge.copyWith(color: colors.textPrimary),
    labelMedium: typography.labelMedium.copyWith(color: colors.textSecondary),
    labelSmall: typography.labelSmall.copyWith(color: colors.textTertiary),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: typography.fontFamily,

    colorScheme: ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: Colors.white,
      primaryContainer: colors.primaryLight,
      onPrimaryContainer: colors.primaryDark,
      secondary: colors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: colors.secondaryLight,
      onSecondaryContainer: colors.secondaryDark,
      surface: colors.surface,
      onSurface: colors.onSurface,
      surfaceContainerHighest: colors.surfaceVariant,
      error: colors.error,
      onError: colors.onError,
      errorContainer: colors.errorLight,
      onErrorContainer: colors.errorDark,
      outline: colors.border,
      shadow: colors.shadow,
    ),

    scaffoldBackgroundColor: colors.background,

    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: colors.surface,
      foregroundColor: colors.textPrimary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      titleTextStyle: typography.titleLarge.copyWith(color: colors.textPrimary),
      iconTheme: IconThemeData(
        color: colors.textPrimary,
        size: AppSpacing.iconMD,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: AppSpacing.elevation2,
      color: colors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding,
        vertical: AppSpacing.sm,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppSpacing.elevation2,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.buttonPaddingHorizontal,
          vertical: AppSpacing.buttonPaddingVertical,
        ),
        textStyle: typography.button,
        minimumSize: const Size(120, 48),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.buttonPaddingHorizontal,
          vertical: AppSpacing.buttonPaddingVertical,
        ),
        textStyle: typography.button,
        minimumSize: const Size(120, 48),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.primary,
        side: BorderSide(color: colors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.buttonPaddingHorizontal,
          vertical: AppSpacing.buttonPaddingVertical,
        ),
        textStyle: typography.button,
        minimumSize: const Size(120, 48),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        textStyle: typography.button,
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: colors.textPrimary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.inputPaddingHorizontal,
        vertical: AppSpacing.inputPaddingVertical,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: colors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: colors.border.withValues(alpha: 0.5)),
      ),
      labelStyle: typography.inputLabel.copyWith(color: colors.textSecondary),
      hintStyle: typography.inputHint.copyWith(color: colors.textTertiary),
      errorStyle: typography.inputError.copyWith(color: colors.error),
    ),

    textTheme: textTheme,

    iconTheme: IconThemeData(
      color: colors.textPrimary,
      size: AppSpacing.iconMD,
    ),

    dividerTheme: DividerThemeData(
      color: colors.divider,
      thickness: AppSpacing.dividerThickness,
      space: AppSpacing.lg,
    ),

    dialogTheme: DialogThemeData(
      elevation: AppSpacing.elevation8,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
      ),
      titleTextStyle: typography.titleLarge.copyWith(color: colors.textPrimary),
      contentTextStyle: typography.bodyMedium.copyWith(
        color: colors.textSecondary,
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: colors.surfaceVariant,
      contentTextStyle: typography.bodyMedium.copyWith(
        color: colors.textPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: AppSpacing.elevation4,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: colors.surfaceVariant,
      selectedColor: colors.primary,
      disabledColor: colors.textDisabled,
      labelStyle: typography.labelMedium,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
      ),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.primary),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.textTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: AppSpacing.elevation4,
      selectedLabelStyle: typography.labelSmall,
      unselectedLabelStyle: typography.labelSmall,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLG),
          topRight: Radius.circular(AppSpacing.radiusLG),
        ),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM / 2),
      ),
    ),

    extensions: [
      AppSemanticColors(
        success: colors.success,
        successLight: colors.successLight,
        successDark: colors.successDark,
        onSuccess: colors.onSuccess,
        warning: colors.warning,
        warningLight: colors.warningLight,
        warningDark: colors.warningDark,
        onWarning: colors.onWarning,
        info: colors.info,
        infoLight: colors.infoLight,
        infoDark: colors.infoDark,
        onInfo: colors.onInfo,
      ),
    ],
  );
}

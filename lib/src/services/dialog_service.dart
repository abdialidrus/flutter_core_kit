import 'package:flutter/material.dart';
import '../ui/theme/theme.dart';

/// Centralized helper for standardized dialogs.
/// Pulls all styling from the active [Theme] — no app-specific colors baked in.
///
/// Usage:
/// ```dart
/// final confirmed = await DialogHelper.showConfirmation(
///   context: context,
///   title: 'Konfirmasi Logout',
///   message: 'Apakah Anda yakin ingin keluar dari aplikasi?',
///   confirmText: 'Keluar',
///   isDestructive: true,
/// );
/// ```
class DialogHelper {
  DialogHelper._();

  static const double _borderRadius = AppSpacing.radiusLG;
  static const double _iconBackgroundSize = 56.0;

  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String cancelText = 'Cancel',
    String confirmText = 'Confirm',
    bool isDestructive = false,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveIcon =
        icon ??
        (isDestructive
            ? Icons.warning_amber_rounded
            : Icons.help_outline_rounded);
    final effectiveIconColor =
        iconColor ?? (isDestructive ? colorScheme.error : colorScheme.primary);

    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => _buildDialog(
        context: dialogContext,
        icon: effectiveIcon,
        iconColor: effectiveIconColor,
        title: title,
        message: message,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelText),
          ),
          const SizedBox(width: AppSpacing.sm),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: isDestructive
                  ? colorScheme.error
                  : colorScheme.primary,
              foregroundColor: isDestructive
                  ? colorScheme.onError
                  : colorScheme.onPrimary,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    IconData icon = Icons.info_outline_rounded,
    Color? iconColor,
    Color? buttonColor,
    Color? onButtonColor,
    bool barrierDismissible = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => _buildDialog(
        context: dialogContext,
        icon: icon,
        iconColor: iconColor ?? colorScheme.primary,
        title: title,
        message: message,
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onPressed?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: buttonColor ?? colorScheme.primary,
              foregroundColor: onButtonColor ?? colorScheme.onPrimary,
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    bool barrierDismissible = true,
  }) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return showInfo(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      icon: Icons.check_circle_outline_rounded,
      iconColor: semantic.success,
      buttonColor: semantic.success,
      onButtonColor: semantic.onSuccess,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showError({
    required BuildContext context,
    String title = 'Error',
    required String message,
    String buttonText = 'Close',
    VoidCallback? onPressed,
    bool barrierDismissible = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return showInfo(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      icon: Icons.error_outline_rounded,
      iconColor: colorScheme.error,
      buttonColor: colorScheme.error,
      onButtonColor: colorScheme.onError,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showWarning({
    required BuildContext context,
    String title = 'Warning',
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    bool barrierDismissible = true,
  }) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return showInfo(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      icon: Icons.warning_amber_rounded,
      iconColor: semantic.warningDark,
      buttonColor: semantic.warningDark,
      onButtonColor: semantic.onWarning,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showLoading(
    BuildContext context, {
    String message = 'Please wait...',
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          elevation: AppSpacing.elevation4,
          backgroundColor: Theme.of(dialogContext).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Flexible(
                  child: Text(
                    message,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) navigator.pop();
  }

  static Future<T?> showCustom<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? padding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        elevation: AppSpacing.elevation4,
        backgroundColor: Theme.of(dialogContext).cardColor,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.cardPaddingLarge),
          child: child,
        ),
      ),
    );
  }

  static Widget _buildDialog({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required List<Widget> actions,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      elevation: AppSpacing.elevation4,
      backgroundColor: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: _iconBackgroundSize,
                height: _iconBackgroundSize,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: AppSpacing.iconLG),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
          ],
        ),
      ),
    );
  }
}

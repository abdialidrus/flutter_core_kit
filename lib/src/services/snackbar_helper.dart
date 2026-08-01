import 'package:flutter/material.dart';
import '../ui/theme/theme.dart';

/// Centralized helper for in-app snackbars.
/// Uses [ScaffoldMessenger] so hit-testing stays scoped to the snackbar itself
/// — other widgets (e.g. BottomNavigationBar) remain fully tappable while
/// the snackbar is visible.
///
/// Usage:
///   SnackbarHelper.success(context, 'Product added to cart');
///   SnackbarHelper.error(context, 'Something went wrong');
class SnackbarHelper {
  SnackbarHelper._();

  static const double _borderRadius = 10.0;
  static const Duration _duration = Duration(seconds: 4);

  static void success(BuildContext context, String message, {String? title}) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    _show(
      context: context,
      message: message,
      title: title,
      backgroundColor: semantic.success,
      foregroundColor: semantic.onSuccess,
    );
  }

  static void error(BuildContext context, String message, {String? title}) {
    final colorScheme = Theme.of(context).colorScheme;
    _show(
      context: context,
      message: message,
      title: title,
      backgroundColor: colorScheme.error,
      foregroundColor: colorScheme.onError,
    );
  }

  static void info(BuildContext context, String message, {String? title}) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    _show(
      context: context,
      message: message,
      title: title,
      backgroundColor: semantic.info,
      foregroundColor: semantic.onInfo,
    );
  }

  static void warning(BuildContext context, String message, {String? title}) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    _show(
      context: context,
      message: message,
      title: title,
      backgroundColor: semantic.warningDark,
      foregroundColor: semantic.onWarning,
    );
  }

  static void _show({
    required BuildContext context,
    required String message,
    String? title,
    required Color backgroundColor,
    required Color foregroundColor,
    Duration? duration,
  }) {
    final textTheme = Theme.of(context).textTheme;
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: backgroundColor,
      duration: duration ?? _duration,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_borderRadius),
          topRight: Radius.circular(_borderRadius),
        ),
      ),
      padding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title.isNotEmpty) ...[
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(color: foregroundColor),
              ),
              const SizedBox(height: 2),
            ],
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(color: foregroundColor),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

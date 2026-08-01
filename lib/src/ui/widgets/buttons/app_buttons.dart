import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum ButtonIconPosition { start, end }

/// Primary Button Widget
/// Full-width button using the app's ElevatedButtonTheme.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSpacing.iconSM),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(text),
            ],
          );

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? (isFullWidth ? double.infinity : 120),
          height ?? 48,
        ),
      ),
      child: buttonChild,
    );

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// Secondary Button Widget
/// Outlined button using the app's OutlinedButtonTheme.
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(primary),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSpacing.iconSM),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(text),
            ],
          );

    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(
          width ?? (isFullWidth ? double.infinity : 120),
          height ?? 48,
        ),
      ),
      child: buttonChild,
    );

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// Danger Button Widget
/// For destructive actions (delete/unassign). Deliberately overrides the
/// default ElevatedButtonTheme colors with the app's semantic error color.
class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;

  const DangerButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onError),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSpacing.iconSM),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(text),
            ],
          );

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        minimumSize: Size(
          width ?? (isFullWidth ? double.infinity : 120),
          height ?? 48,
        ),
      ),
      child: buttonChild,
    );

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// Text Button Widget
class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonIconPosition iconPosition;
  final Color? color;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconPosition = ButtonIconPosition.start,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final label = Text(text);
    final iconWidget = icon != null
        ? Icon(icon, size: AppSpacing.iconSM)
        : null;

    final children = iconWidget == null
        ? [label]
        : iconPosition == ButtonIconPosition.start
            ? [iconWidget, const SizedBox(width: AppSpacing.sm), label]
            : [label, const SizedBox(width: AppSpacing.sm), iconWidget];

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: color),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

/// Icon Button Widget
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.size = AppSpacing.iconMD,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size),
      color: color,
      style: IconButton.styleFrom(backgroundColor: backgroundColor),
      tooltip: tooltip,
    );
  }
}

/// Floating Action Button Widget
class AppFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isExtended;
  final String? label;

  const AppFAB({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.isExtended = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (isExtended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
        tooltip: tooltip,
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: Icon(icon),
    );
  }
}

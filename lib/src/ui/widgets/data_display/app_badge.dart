import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum AppBadgeVariant { primary, success, warning, error, info, neutral }

/// Generic pill/badge — a color + label. Domain-specific badges (e.g. a
/// TMS `DeliveryStatusBadge` with its own status→label mapping) should be
/// built *on top of* this rather than duplicating the pill styling.
class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeVariant variant;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.neutral,
    this.icon,
  });

  ({Color background, Color foreground}) _colorsFor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final semantic = Theme.of(context).extension<AppSemanticColors>();

    switch (variant) {
      case AppBadgeVariant.primary:
        return (
          background: colorScheme.primary.withValues(alpha: 0.12),
          foreground: colorScheme.primary,
        );
      case AppBadgeVariant.success:
        final c = semantic?.success ?? Colors.green;
        return (background: c.withValues(alpha: 0.12), foreground: c);
      case AppBadgeVariant.warning:
        final c = semantic?.warningDark ?? Colors.orange;
        return (background: c.withValues(alpha: 0.12), foreground: c);
      case AppBadgeVariant.error:
        return (
          background: colorScheme.error.withValues(alpha: 0.12),
          foreground: colorScheme.error,
        );
      case AppBadgeVariant.info:
        final c = semantic?.info ?? colorScheme.primary;
        return (background: c.withValues(alpha: 0.12), foreground: c);
      case AppBadgeVariant.neutral:
        return (
          background: colorScheme.onSurfaceVariant.withValues(alpha: 0.12),
          foreground: colorScheme.onSurfaceVariant,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppSpacing.iconXS, color: colors.foreground),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(color: colors.foreground),
          ),
        ],
      ),
    );
  }
}

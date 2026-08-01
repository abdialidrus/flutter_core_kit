import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Thin [ListTile] wrapper standardizing title/subtitle typography so rows
/// look consistent across FMS/TMS/Edash/KidTube without each screen picking
/// its own text styles.
class AppListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;
  final EdgeInsetsGeometry? contentPadding;

  const AppListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: leading,
      title: Text(title, style: textTheme.bodyLarge),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
      selected: selected,
      selectedTileColor: colorScheme.primary.withValues(alpha: 0.06),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.pagePadding,
            vertical: AppSpacing.xxs,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
      ),
    );
  }
}

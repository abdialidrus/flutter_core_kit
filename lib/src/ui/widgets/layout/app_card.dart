import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Thin [Card] wrapper. Elevation/radius/color already come from
/// `CardThemeData` in `buildAppTheme` — this just standardizes padding
/// and adds an optional tap handler.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final Clip? clipBehavior;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.cardPadding),
    this.onTap,
    this.margin,
    this.elevation = 0,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      elevation: elevation,
      clipBehavior: onTap != null && clipBehavior == null
          ? Clip.antiAlias
          : clipBehavior,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

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

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.cardPadding),
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      margin: margin,
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) return card;

    return Card(
      margin: margin,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

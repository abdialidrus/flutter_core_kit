import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Thin [Divider] wrapper so call sites don't repeat spacing/thickness
/// constants. Color/thickness/space already come from `DividerThemeData`.
class AppDivider extends StatelessWidget {
  final double? indent;
  final double? endIndent;

  const AppDivider({super.key, this.indent, this.endIndent});

  @override
  Widget build(BuildContext context) {
    return Divider(indent: indent, endIndent: endIndent);
  }
}

/// Vertical divider variant, for use inside a [Row] (e.g. separating stat
/// values in a summary bar).
class AppVerticalDivider extends StatelessWidget {
  final double? indent;
  final double? endIndent;

  const AppVerticalDivider({super.key, this.indent, this.endIndent});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: AppSpacing.lg,
      thickness: AppSpacing.dividerThickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

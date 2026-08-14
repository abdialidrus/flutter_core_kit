import 'package:flutter/material.dart';

/// Section title row with an optional trailing action ("See all", "Edit"...).
/// Common in dashboard/list screens (Edash cards, KidTube category rows).
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final TextStyle? titleStyle;
  final VoidCallback? onActionTap;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.titleStyle,
    this.actionText,
    this.onActionTap,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: titleStyle ?? textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (actionText != null && onActionTap != null)
            TextButton(onPressed: onActionTap, child: Text(actionText!)),
        ],
      ),
    );
  }
}

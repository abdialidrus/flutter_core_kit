import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Avatar with an image (network or asset) and automatic fallback to
/// initials when no image is available or fails to load. Useful for
/// driver/user profile displays across FMS and TMS.
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = AppSpacing.avatarMD,
    this.backgroundColor,
    this.foregroundColor,
  });

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? colorScheme.primary.withValues(alpha: 0.12);
    final fg = foregroundColor ?? colorScheme.primary;

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: bg,
      foregroundImage:
          (imageUrl != null && imageUrl!.isNotEmpty)
              ? NetworkImage(imageUrl!)
              : null,
      onForegroundImageError: (imageUrl != null && imageUrl!.isNotEmpty)
          ? (_, _) {}
          : null,
      child: Text(
        _initials,
        style: TextStyle(
          color: fg,
          fontSize: size * 0.38,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

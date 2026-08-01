import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Lightweight shimmer effect with no external package dependency —
/// animates a gradient sweep across a base shape. Use to build skeleton
/// loaders (list rows, cards) instead of a bare spinner.
class AppShimmerLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const AppShimmerLoader({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppSpacing.radiusSM)),
  });

  @override
  State<AppShimmerLoader> createState() => _AppShimmerLoaderState();
}

class _AppShimmerLoaderState extends State<AppShimmerLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context)
        .colorScheme
        .onSurfaceVariant
        .withValues(alpha: 0.08);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: widget.borderRadius,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment(-1.0 - _controller.value * 2, 0),
                end: Alignment(1.0 - _controller.value * 2, 0),
                colors: [baseColor, highlightColor, baseColor],
                stops: const [0.35, 0.5, 0.65],
              ).createShader(bounds);
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              color: baseColor,
            ),
          ),
        );
      },
    );
  }
}

/// Convenience preset: a shimmer skeleton shaped like a typical list row
/// (avatar + two lines of text).
class AppShimmerListTile extends StatelessWidget {
  const AppShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppShimmerLoader(
            width: AppSpacing.avatarMD,
            height: AppSpacing.avatarMD,
            borderRadius: BorderRadius.circular(AppSpacing.avatarMD / 2),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmerLoader(height: 14),
                SizedBox(height: AppSpacing.sm),
                AppShimmerLoader(width: 160, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

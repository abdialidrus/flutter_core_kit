import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Slim banner for "You're offline" style messages. Purely presentational —
/// drive [isVisible] from your own connectivity stream (e.g. `connectivity_plus`)
/// at the app level, since core_kit shouldn't dictate that dependency.
class ConnectivityBanner extends StatelessWidget {
  final bool isVisible;
  final String message;
  final IconData icon;

  const ConnectivityBanner({
    super.key,
    required this.isVisible,
    this.message = 'You are offline',
    this.icon = Icons.wifi_off_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>();
    final warningColor = semantic?.warningDark ??
        Theme.of(context).colorScheme.error;
    final onWarningColor = semantic?.onWarning ?? Colors.white;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: isVisible
          ? Container(
              width: double.infinity,
              color: warningColor,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: AppSpacing.iconSM, color: onWarningColor),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: onWarningColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

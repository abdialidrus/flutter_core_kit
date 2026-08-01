import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Failed-request placeholder — icon + message + retry button.
/// Pairs naturally with a `core/error` failure-mapping layer: pass the
/// mapped user-facing message in [message].
class ErrorStateWidget extends StatelessWidget {
  final String? title;
  final String message;
  final IconData icon;
  final String retryText;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    this.title,
    required this.message,
    this.icon = Icons.cloud_off_rounded,
    this.retryText = 'Retry',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSpacing.iconXL, color: colorScheme.error),
            const SizedBox(height: AppSpacing.lg),
            if (title != null) ...[
              Text(
                title!,
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: AppSpacing.iconSM),
                label: Text(retryText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

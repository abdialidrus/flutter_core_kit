import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Centralized helper for modal bottom sheets — same reasoning as
/// `DialogHelper`: consistent rounded-top shape, padding, and a drag handle,
/// without every call site rebuilding that scaffolding.
class AppBottomSheet {
  AppBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
    bool showDragHandle = true,
    EdgeInsetsGeometry? padding,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: MediaQuery.of(sheetContext).viewInsets,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(AppSpacing.cardPaddingLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showDragHandle)
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: Theme.of(sheetContext)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                      ),
                    ),
                  if (title != null) ...[
                    Text(title, style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

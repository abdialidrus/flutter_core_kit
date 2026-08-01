import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Checkbox with a tappable label, consistent spacing, and theme-driven
/// text style.
class AppCheckboxTile extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;
  final bool enabled;

  const AppCheckboxTile({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: enabled ? () => onChanged(!value) : null,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: enabled ? onChanged : null,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(child: Text(label, style: textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}

/// Radio option with a tappable label. Use inside a list, one per value of [T].
class AppRadioTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T?> onChanged;
  final bool enabled;

  const AppRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: enabled ? () => onChanged(value) : null,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            IgnorePointer(
              child: RadioGroup<T>(
                groupValue: groupValue,
                onChanged: onChanged,
                child: Radio<T>(value: value),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(child: Text(label, style: textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}

/// Switch row with label + optional description, matching settings-screen
/// layouts.
class AppSwitchTile extends StatelessWidget {
  final bool value;
  final String label;
  final String? description;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  const AppSwitchTile({
    super.key,
    required this.value,
    required this.label,
    this.description,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: enabled ? () => onChanged(!value) : null,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: textTheme.bodyLarge),
                  if (description != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      description!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: enabled ? onChanged : null,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// Generic themed dropdown. Item label is derived via [labelBuilder] so
/// this works with any type — enums, models, strings — without each app
/// writing its own `DropdownButtonFormField` boilerplate.
class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T item) labelBuilder;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(T?)? validator;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.label,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: AppSpacing.iconSM)
            : null,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                labelBuilder(item),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
    );
  }
}

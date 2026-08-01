import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import '../../theme/theme.dart';

/// Search field with a built-in debounced callback and clear button.
/// Pairs well with server-side search APIs (e.g. `?search=` params).
class AppSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onCleared;
  final Duration debounceDuration;
  final bool autofocus;

  const AppSearchField({
    super.key,
    this.controller,
    this.hint = 'Search',
    required this.onChanged,
    this.onCleared,
    this.debounceDuration = const Duration(milliseconds: 400),
    this.autofocus = false,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller;
  late final bool _ownsController;
  late final Debouncer _debouncer;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    _debouncer = Debouncer(delay: widget.debounceDuration);
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
    _debouncer.run(() => widget.onChanged(_controller.text));
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _debouncer.dispose();
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onCleared?.call();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search_rounded, size: AppSpacing.iconSM),
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(Icons.close_rounded, size: AppSpacing.iconSM),
                onPressed: _clear,
              )
            : null,
      ),
    );
  }
}

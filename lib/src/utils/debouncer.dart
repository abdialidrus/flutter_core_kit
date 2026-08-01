import 'dart:async';

/// Simple debouncer for search-as-you-type, autosave, or any input where
/// you want to wait for a pause in activity before firing a callback.
///
/// ```dart
/// final debouncer = Debouncer(delay: const Duration(milliseconds: 400));
/// // ...
/// debouncer.run(() => performSearch(query));
/// // ...
/// debouncer.dispose(); // call in State.dispose()
/// ```
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 400)});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
  }
}

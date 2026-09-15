import 'dart:async';

/// Debounces a frequently-invoked callback (e.g. search-as-you-type).
class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 350)});

  final Duration duration;
  Timer? _timer;

  /// Schedules [callback] to run after [duration] of quiet time.
  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  /// Cancels any pending invocation.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Immediately cancels and runs [callback] now.
  void flush(void Function() callback) {
    _timer?.cancel();
    _timer = null;
    callback();
  }
}

import 'package:logging/logging.dart';
import 'package:the_logger/the_logger.dart';

/// Centralized logger service for the app.
///
/// Usage:
///   LoggerService.http.info('message');
///   LoggerService.http.warning('message');
///   LoggerService.http.severe('message', error, stackTrace);
///
/// Categories:
///   LoggerService.http    → HTTP requests & responses
///   LoggerService.app     → General app events
///   LoggerService.auth    → Authentication events
///   LoggerService.ui      → UI / navigation events
class LoggerService {
  LoggerService._();

  // ── Named loggers per category ───────────────────────────────────────────
  static final Logger http = Logger('HTTP');
  static final Logger app = Logger('APP');
  static final Logger auth = Logger('AUTH');
  static final Logger ui = Logger('UI');

  // ── Bootstrap ────────────────────────────────────────────────────────────

  /// Call once in [main()] before runApp().
  ///
  /// [TheLogger] automatically captures all [logging] package records once
  /// initialized — no manual [Logger.root.onRecord] listener needed.
  static Future<void> init({bool verbose = false}) async {
    // Set hierarchy root level
    Logger.root.level = verbose ? Level.ALL : Level.INFO;

    // TheLogger captures all logging records automatically via its own
    // internal Logger.root.onRecord listener.
    await TheLogger.i().init();
  }

  // ── HTTP helpers ─────────────────────────────────────────────────────────

  static void logRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) {
    final buffer = StringBuffer()
      ..writeln('┌─ 🔵 $method REQUEST ────────────────────')
      ..writeln('│ URL     : $url');

    if (headers != null && headers.isNotEmpty) {
      // Mask sensitive headers
      final safe = headers.map((k, v) {
        final lower = k.toLowerCase();
        if (lower == 'authorization' || lower == 'cookie') {
          return MapEntry(k, '${v.substring(0, v.length.clamp(0, 12))}…');
        }
        return MapEntry(k, v);
      });
      buffer.writeln('│ Headers : $safe');
    }

    if (body != null) {
      buffer.writeln('│ Body    : $body');
    }

    buffer.write('└────────────────────────────────────');
    // config level → 🔵 blue in console, indicating outgoing request
    http.config(buffer.toString());
  }

  static void logResponse({
    required String method,
    required String url,
    required int statusCode,
    String? body,
    Map<String, String>? headers,
  }) {
    final isError = statusCode >= 400;
    final icon = isError ? '🔴' : '🟢';
    final buffer = StringBuffer()
      ..writeln('┌─ $icon $method RESPONSE ────────────────')
      ..writeln('│ URL    : $url')
      ..writeln('│ Status : $statusCode');

    if (body != null) {
      // Truncate very large bodies so the log stays readable
      final preview = body.length > 800 ? '${body.substring(0, 800)}…' : body;
      buffer.writeln('│ Body   : $preview');
    }

    buffer.write('└────────────────────────────────────');

    if (isError) {
      // warning level → 🟡 yellow for 4xx/5xx
      http.warning(buffer.toString());
    } else {
      // fine level → 🟢 green for 2xx/3xx
      http.fine(buffer.toString());
    }
  }

  static void logError({
    required String method,
    required String url,
    required Object error,
    StackTrace? stackTrace,
  }) {
    http.severe('[$method] $url → ${error.runtimeType}', error, stackTrace);
  }
}

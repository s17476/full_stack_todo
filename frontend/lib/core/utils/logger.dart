import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
  );

  static Future<void> close() => _logger.close();

  static void d(
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.d(message, time: time, error: error, stackTrace: stackTrace);

  static void e(
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(message, time: time, error: error, stackTrace: stackTrace);

  static void f(
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.f(message, time: time, error: error, stackTrace: stackTrace);

  static void i(
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.i(message, time: time, error: error, stackTrace: stackTrace);

  static bool isClosed() => _logger.isClosed();

  static void log(
    Level level,
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.log(level, message,
          time: time, error: error, stackTrace: stackTrace);

  static void t(
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.t(message, time: time, error: error, stackTrace: stackTrace);

  static void w(
    message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.w(message, time: time, error: error, stackTrace: stackTrace);
}

export './bad_request_exception.dart';
export './not_found_exception.dart';

abstract class HttpException implements Exception {
  const HttpException(this.message, this.statusCode);
  final String message;
  final int statusCode;

  @override
  String toString() => '$runtimeType: $message';
}

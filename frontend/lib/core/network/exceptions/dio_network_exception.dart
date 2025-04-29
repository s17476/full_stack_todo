import 'package:dio/dio.dart';
import 'package:exceptions/exceptions.dart';

class DioNetworkException extends DioException implements NetworkException {
  DioNetworkException({
    required this.errors,
    required super.message,
    required super.requestOptions,
  });

  @override
  int? get statusCode => super.response?.statusCode;

  @override
  final Map<String, List<String>> errors;
}

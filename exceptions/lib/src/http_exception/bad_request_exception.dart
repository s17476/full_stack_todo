import 'dart:io';

import 'package:exceptions/src/http_exception/http_exception.dart';

class BadRequestException extends HttpException {
  const BadRequestException({required String message, this.errors = const {}})
    : super(message, HttpStatus.badRequest);

  final Map<String, List<String>> errors;
}

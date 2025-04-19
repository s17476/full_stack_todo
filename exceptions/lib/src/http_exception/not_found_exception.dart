import 'dart:io';

import 'package:exceptions/src/http_exception/http_exception.dart';

class NotFoundException extends HttpException {
  const NotFoundException(String message) : super(message, HttpStatus.notFound);
}

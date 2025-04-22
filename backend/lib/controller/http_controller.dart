import 'dart:async';

import 'package:dart_frog/dart_frog.dart';

abstract class HttpController {
  FutureOr<Response> index(Request request);

  FutureOr<Response> store(Request request);

  FutureOr<Response> show(Request request, String id);

  FutureOr<Response> update(Request request, String id);

  FutureOr<Response> destroy(Request request, String id);
}

import 'dart:io';

import 'package:backend/todo/controller/todo_controller.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final controller = context.read<TodoController>();

  return switch (context.request.method) {
    HttpMethod.get => controller.index(context.request),
    HttpMethod.post => controller.store(context.request),
    _ => Response.json(
        body: {'error': '👀 Looks like you are lost 🔦'},
        statusCode: HttpStatus.methodNotAllowed,
      ),
  };
}

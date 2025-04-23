import 'dart:io';

import 'package:backend/todo/controller/todo_controller.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final todoController = context.read<TodoController>();

  return switch (context.request.method) {
    HttpMethod.get => todoController.show(context.request, id),
    HttpMethod.put || HttpMethod.patch => todoController.update(
        context.request,
        id,
      ),
    HttpMethod.delete => todoController.destroy(context.request, id),
    _ => Response.json(
        body: {'error': '👀 Looks like you are lost 🔦'},
        statusCode: HttpStatus.methodNotAllowed,
      ),
  };
}

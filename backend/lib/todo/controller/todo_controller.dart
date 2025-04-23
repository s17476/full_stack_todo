import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:backend/controller/http_controller.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:exceptions/exceptions.dart';

import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:models/models.dart';

import 'package:repository/repository.dart';
import 'package:typedefs/typedefs.dart';

class TodoController extends HttpController {
  TodoController(this._repo);

  final TodoRepository _repo;

  @override
  FutureOr<Response> index(Request request) async {
    final failureOrTodos = await _repo.getTodos();

    return failureOrTodos.fold(
      _failureResponse,
      (todos) => Response.json(
        body: todos.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  FutureOr<Response> show(Request request, String id) async {
    final failureOrId = mapTodoId(id);

    return await failureOrId.fold(
      _failureResponse,
      (id) async {
        final failureOrTodo = await _repo.getTodoById(id);

        return failureOrTodo.fold(
          _failureResponse,
          (todo) => Response.json(
            body: todo.toJson(),
          ),
        );
      },
    );
  }

  @override
  FutureOr<Response> destroy(Request request, String id) async {
    final failureOrId = mapTodoId(id);

    return await failureOrId.fold(
      _failureResponse,
      (id) async {
        final failureOrUnit = await _repo.deleteTodo(id);

        return failureOrUnit.fold(
          _failureResponse,
          (_) => Response.json(body: {'message': 'OK'}),
        );
      },
    );
  }

  @override
  FutureOr<Response> store(Request request) async {
    final failureOrParsedBody = await _parseJson(request);

    return await failureOrParsedBody.fold(
      _failureResponse,
      (body) async {
        final failureOrCreateTodoDto = CreateTodoDto.validated(body);

        return await failureOrCreateTodoDto.fold(
          _validationFailureResponse,
          (dto) async {
            final failureOrTodo = await _repo.createTodo(dto);

            return failureOrTodo.fold(
              _failureResponse,
              (todo) => Response.json(
                body: todo.toJson(),
                statusCode: HttpStatus.created,
              ),
            );
          },
        );
      },
    );
  }

  @override
  FutureOr<Response> update(Request request, String id) async {
    final failureOrId = mapTodoId(id);

    return await failureOrId.fold(
      _failureResponse,
      (id) async {
        final failureOrParsedBody = await _parseJson(request);

        return await failureOrParsedBody.fold(
          _failureResponse,
          (body) async {
            final failureOrDto = UpdateTodoDto.validated(body);

            return await failureOrDto.fold(
              _validationFailureResponse,
              (dto) async {
                final failureOrTodo = await _repo.updateTodo(
                  id: id,
                  updateTodoDto: dto,
                );

                return failureOrTodo.fold(
                  _failureResponse,
                  (todo) => Response.json(
                    body: todo.toJson(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> _parseJson(
    Request request,
  ) async {
    try {
      final body = await request.body();

      if (body.isEmpty) {
        throw const BadRequestException(message: 'Invalid body');
      }

      late final Map<String, dynamic> json;

      try {
        json = jsonDecode(body) as Map<String, dynamic>;

        return Right(json);
      } catch (e) {
        throw const BadRequestException(message: 'Invalid body');
      }
    } on BadRequestException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          errors: {},
        ),
      );
    }
  }

  Response _failureResponse(Failure failure) {
    return Response.json(
      body: {'message': failure.message},
      statusCode: failure.statusCode,
    );
  }

  Response _validationFailureResponse(ValidationFailure failure) {
    return Response.json(
      body: {
        'message': failure.message,
        'errors': failure.errors,
      },
      statusCode: failure.statusCode,
    );
  }
}


// https://saileshdahal.com.np/building-a-fullstack-app-with-dartfrog-and-flutter-in-a-monorepo-part-4

// Implementing routes
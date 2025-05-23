import 'package:data_source/data_source.dart';
import 'package:exceptions/exceptions.dart';

import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:models/models.dart';
import 'package:repository/repository.dart';
import 'package:typedefs/typedefs.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this.dataSource);

  final TodoDataSource dataSource;

  @override
  Future<Either<Failure, Todo>> createTodo(CreateTodoDto createTodoDto) async {
    try {
      final todo = await dataSource.createTodo(createTodoDto);

      return Right(todo);
    } on ServerException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(TodoId id) async {
    try {
      final failureOrTodo = await getTodoById(id);

      return await failureOrTodo.fold(
        left,
        (todo) async {
          await dataSource.deleteTodoById(id);

          return const Right(unit);
        },
      );
    } on ServerException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(TodoId id) async {
    try {
      final res = await dataSource.getTodoById(id);

      return Right(res);
    } on NotFoundException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    } on ServerException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      return Right(await dataSource.getAllTodo());
    } on ServerException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo({
    required TodoId id,
    required UpdateTodoDto updateTodoDto,
  }) async {
    try {
      return Right(
        await dataSource.updateTodo(
          id: id,
          todo: updateTodoDto,
        ),
      );
    } on NotFoundException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    } on ServerException catch (e) {
      print(e.message);

      return Left(
        ServerFailure(message: e.message),
      );
    }
  }
}

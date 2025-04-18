import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:models/models.dart';
import 'package:typedefs/typedefs.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();

  Future<Either<Failure, Todo>> getTodoById(TodoId id);

  Future<Either<Failure, Todo>> createTodo(CreateTodoDto createTodoDto);

  Future<Either<Failure, Todo>> updateTodo({
    required TodoId id,
    required UpdateTodoDto updateTodoDto,
  });

  Future<Either<Failure, void>> deleteTodo(TodoId id);
}

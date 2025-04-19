import 'package:exceptions/exceptions.dart';
import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Primary key type for a Todo.
typedef TodoId = int;

Either<Failure, TodoId> mapTodoId(String id) {
  try {
    final todoId = int.tryParse(id);
    if (todoId == null) throw const BadRequestException(message: 'Invalid id');
    return Right(todoId);
  } on BadRequestException catch (e) {
    return Left(RequestFailure(message: e.message, statusCode: e.statusCode));
  }
}

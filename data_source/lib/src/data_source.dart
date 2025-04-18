import 'package:models/models.dart';
import 'package:typedefs/typedefs.dart';

abstract class TodoDataSource {
  Future<List<Todo>> getAllTodo();

  Future<Todo> getTodoById(TodoId id);

  Future<Todo> createTodo(CreateTodoDto todo);

  Future<Todo> updateTodo({required TodoId id, required UpdateTodoDto todo});

  Future<void> deleteTodoById(TodoId id);
}

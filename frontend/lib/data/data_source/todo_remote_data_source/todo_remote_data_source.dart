import 'package:data_source/data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fullstack_todo/data/data_source/todo_http_client/todos_http_client.dart';
import 'package:injectable/injectable.dart';
import 'package:models/models.dart';
import 'package:typedefs/typedefs.dart';

@LazySingleton(as: TodoDataSource)
class TodosRemoteDataSource implements TodoDataSource {
  const TodosRemoteDataSource(this.httpClient);

  final TodosHttpClient httpClient;

  @override
  Future<Todo> createTodo(CreateTodoDto todo) => httpClient.createTodo(todo);

  @override
  Future<Unit> deleteTodoById(TodoId id) async {
    await httpClient.deleteTodoById(id);

    return unit;
  }

  @override
  Future<List<Todo>> getAllTodo() => httpClient.getAllTodo();

  @override
  Future<Todo> getTodoById(TodoId id) => httpClient.getTodoById(id);

  @override
  Future<Todo> updateTodo({required TodoId id, required UpdateTodoDto todo}) =>
      httpClient.updateTodo(id, todo);
}

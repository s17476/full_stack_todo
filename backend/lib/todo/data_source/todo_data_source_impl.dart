import 'package:backend/db/database_connection.dart';
import 'package:data_source/data_source.dart';
import 'package:exceptions/exceptions.dart' as exc;
import 'package:fpdart/fpdart.dart';
import 'package:models/models.dart';
import 'package:postgres/postgres.dart';
import 'package:typedefs/typedefs.dart';

class TodoDataSourceImpl implements TodoDataSource {
  const TodoDataSourceImpl(this._databaseConnection);
  final DatabaseConnection _databaseConnection;

  @override
  Future<Todo> createTodo(CreateTodoDto todo) async {
    try {
      await _databaseConnection.connect();

      final result = await _databaseConnection.db.execute(
        Sql.named('''
        INSERT INTO todos (title, description, completed, created_at)
        VALUES (@title, @description, @completed, @created_at) RETURNING *
        '''),
        parameters: {
          'title': todo.title,
          'description': todo.description,
          'completed': false,
          'created_at': DateTime.now(),
        },
      );

      if (result.affectedRows == 0) {
        throw const exc.ServerException('Failed to create todo');
      }

      final todoMap = result.first.toColumnMap();

      return Todo(
        id: todoMap['id'] as int,
        title: todoMap['title'] as String,
        description: todoMap['description'] as String,
        createdAt: todoMap['created_at'] as DateTime,
      );
    } on PgException catch (e) {
      throw exc.ServerException(e.message);
    } finally {
      await _databaseConnection.close();
    }
  }

  @override
  Future<Unit> deleteTodoById(TodoId id) async {
    try {
      await _databaseConnection.connect();

      await _databaseConnection.db.execute(
        Sql.named('DELETE FROM todos WHERE id = @id'),
        parameters: {'id': id},
      );

      return unit;
    } on PgException catch (e) {
      throw exc.ServerException(e.message);
    } finally {
      await _databaseConnection.close();
    }
  }

  @override
  Future<List<Todo>> getAllTodo() async {
    try {
      await _databaseConnection.connect();

      final result = await _databaseConnection.db.execute(
        Sql.named('SELECT * FROM todos'),
      );

      final data =
          result.map((e) => e.toColumnMap()).map(Todo.fromJson).toList();

      return data;
    } on PgException catch (e) {
      throw exc.ServerException(e.message);
    } finally {
      await _databaseConnection.close();
    }
  }

  @override
  Future<Todo> getTodoById(TodoId id) async {
    try {
      await _databaseConnection.connect();

      final result = await _databaseConnection.db.execute(
        Sql.named('SELECT * FROM todos WHERE id = @id'),
        parameters: {'id': id},
      );

      if (result.isEmpty) {
        throw const exc.NotFoundException('Todo not found');
      }

      return Todo.fromJson(result.first.toColumnMap());
    } on PgException catch (e) {
      throw exc.ServerException(e.message);
    } finally {
      await _databaseConnection.close();
    }
  }

  @override
  Future<Todo> updateTodo({
    required TodoId id,
    required UpdateTodoDto todo,
  }) async {
    try {
      await _databaseConnection.connect();

      final result = await _databaseConnection.db.execute(
        Sql.named('''
        UPDATE todos
        SET title = COALESCE(@new_title, title),
            description = COALESCE(@new_description, description),
            completed = COALESCE(@new_completed, completed),
            updated_at = current_timestamp
        WHERE id = @id
        RETURNING *
        '''),
        parameters: {
          'id': id,
          'new_title': todo.title,
          'new_description': todo.description,
          'new_completed': todo.completed,
        },
      );

      if (result.isEmpty) {
        throw const exc.NotFoundException('Todo not found');
      }

      return Todo.fromJson(result.first.toColumnMap());
    } on PgException catch (e) {
      throw exc.ServerException(e.message);
    } finally {
      await _databaseConnection.close();
    }
  }
}

import 'package:failures/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fullstack_todo/core/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:models/models.dart';
import 'package:repository/repository.dart';

part 'todos_cubit.freezed.dart';
part 'todos_state.dart';

@lazySingleton
class TodosCubit extends Cubit<TodosState> {
  final TodoRepository _todoRepository;

  TodosCubit(this._todoRepository) : super(TodosState());

  void init() => refresh();

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final response = await _todoRepository.getTodos();

    response.fold(_handleFailure, _handleSuccess);
  }

  Future<void> deleteTodo(Todo todo) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final response = await _todoRepository.deleteTodo(todo.id);

    response.fold(_handleFailure, (_) => _remove(todo));
  }

  Future<void> markCompleted(Todo todo) async {
    if (state.isLoading) return;

    final completed = !todo.completed;
    final todos = _add(todo.copyWith(completed: completed));

    emit(state.copyWith(isLoading: true, failure: null, todos: todos));

    final updateDto = UpdateTodoDto(completed: completed);

    final update = await _todoRepository.updateTodo(
      id: todo.id,
      updateTodoDto: updateDto,
    );

    update.fold(
      (failure) {
        final todos = _add(todo.copyWith(completed: !completed));

        _handleFailure(failure, todos);
      },
      (_) {
        emit(state.copyWith(isLoading: false, failure: null));
      },
    );
  }

  Future<void>? handleTodo([Todo? todo]) {
    return null;
  }

  List<Todo> _add(Todo todo) {
    final todos = [...state.todos];

    final index = todos.indexWhere((element) => element.id == todo.id);

    if (index == -1) {
      todos.insert(0, todo);
    } else {
      todos[index] = todo;
    }

    return todos;
  }

  void _remove(Todo todo) {
    final todos = [...state.todos];

    todos.removeWhere((element) => element.id == todo.id);

    emit(state.copyWith(todos: todos, failure: null, isLoading: false));
  }

  void _handleFailure(Failure failure, [List<Todo>? todos]) {
    var newState = state.copyWith(isLoading: false, failure: failure);

    if (todos != null) {
      newState = newState.copyWith(todos: todos);
    }

    emit(newState);

    Log.e(failure.message);
  }

  void _handleSuccess(List<Todo> todos) =>
      emit(state.copyWith(isLoading: false, todos: todos, failure: null));
}

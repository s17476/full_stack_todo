part of 'todos_cubit.dart';

@freezed
abstract class TodosState with _$TodosState {
  const TodosState._();

  const factory TodosState({
    Failure? failure,
    @Default(false) bool isLoading,
    @Default([]) List<Todo> todos,
  }) = _TodosState;
}

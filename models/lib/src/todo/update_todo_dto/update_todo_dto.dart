import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_todo_dto.freezed.dart';
part 'update_todo_dto.g.dart';

@freezed
abstract class UpdateTodoDto with _$UpdateTodoDto {
  factory UpdateTodoDto({
    String? title,
    String? description,
    bool? completed,
  }) = _UpdateTodoDto;

  factory UpdateTodoDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoDtoFromJson(json);
}

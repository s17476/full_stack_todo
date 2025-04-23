import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/src/converters/date_time_converter.dart';
import 'package:typedefs/typedefs.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Todo({
    required TodoId id,
    required String title,
    @Default('') String description,
    @Default(false) bool? completed,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverterNullable() DateTime? updatedAt,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

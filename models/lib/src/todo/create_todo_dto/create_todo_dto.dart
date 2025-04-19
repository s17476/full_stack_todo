import 'package:exceptions/exceptions.dart';
import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_todo_dto.freezed.dart';
part 'create_todo_dto.g.dart';

@freezed
abstract class CreateTodoDto with _$CreateTodoDto {
  factory CreateTodoDto({required String title, required String description}) =
      _CreateTodoDto;

  factory CreateTodoDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoDtoFromJson(json);

  /// Validates the [CreateTodoDto] and throws a [BadRequestException] if the
  /// validation fails.
  static Either<ValidationFailure, CreateTodoDto> validated(
    Map<String, dynamic> json,
  ) {
    try {
      final errors = <String, List<String>>{};

      final title = json['title'] as String? ?? '';
      if (title.isEmpty) {
        errors['title'] = ['Title is required'];
      }

      final description = json['description'] as String? ?? '';
      if (description.isEmpty) {
        errors['description'] = ['Description is required'];
      }

      if (errors.isEmpty) return Right(CreateTodoDto.fromJson(json));

      throw BadRequestException(message: 'Validation failed', errors: errors);
    } on BadRequestException catch (e) {
      return Left(
        ValidationFailure(
          message: e.message,
          errors: e.errors,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}

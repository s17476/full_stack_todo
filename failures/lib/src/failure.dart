import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';
part 'failure.g.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.network({
    required String message,
    required int statusCode,
    @Default({}) Map<String, List<String>> errors,
  }) = NetworkFailure;

  const factory Failure.request({
    required String message,
    @Default(HttpStatus.badRequest) int statusCode,
  }) = RequestFailure;

  const factory Failure.server({
    required String message,
    @Default(HttpStatus.internalServerError) int statusCode,
  }) = ServerFailure;

  const factory Failure.validation({
    required String message,
    @Default(HttpStatus.badRequest) int statusCode,

    @Default({}) Map<String, List<String>> errors,
  }) = ValidationFailure;

  factory Failure.fromJson(Map<String, Object?> json) =>
      _$FailureFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';
part 'failure.g.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.network({
    required String message,
    required int code,
    @Default([]) List<String> errors,
  }) = NetworkFailure;

  factory Failure.fromJson(Map<String, Object?> json) =>
      _$FailureFromJson(json);
}

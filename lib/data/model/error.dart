import 'dart:convert';

class ErrorModel {
  String error;

  ErrorModel({
    required this.error,
  });

  ErrorModel copyWith({
    String? error,
  }) {
    return ErrorModel(
      error: error ?? this.error,
    );
  }

  factory ErrorModel.fromString(String error) => ErrorModel(
        error: error,
      );

  factory ErrorModel.fromGraphError(List error) => ErrorModel(
        error: error.toString(),
      );
}

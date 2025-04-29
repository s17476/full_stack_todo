class NetworkException implements Exception {
  NetworkException({
    required this.message,
    required this.statusCode,
    this.errors = const {},
  });

  final String message;

  final int statusCode;

  final Map<String, List<String>> errors;
}

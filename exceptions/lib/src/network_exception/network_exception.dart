class NetworkException implements Exception {
  NetworkException({this.errors = const {}});

  int? get statusCode => throw UnimplementedError();

  final Map<String, List<String>> errors;
}

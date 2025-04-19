import 'dart:developer';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';

/// {@template database_connection}
/// Database connection class
/// This class is used to connect to the database
/// {@endtemplate}
class DatabaseConnection {
  /// {@macro database_connection}
  DatabaseConnection(this._dotEnv) {
    _endpoint = Endpoint(
      host: _dotEnv['DB_HOST'] ?? 'localhost',
      port: int.tryParse(_dotEnv['DB_PORT'] ?? '') ?? 5432,
      database: _dotEnv['DB_DATABASE'] ?? 'test',
      username: _dotEnv['DB_USERNAME'] ?? 'test',
      password: _dotEnv['DB_PASSWORD'] ?? 'test',
    );
  }

  final DotEnv _dotEnv;
  late final Endpoint _endpoint;
  Connection? _connection;

  /// Get the database connection
  Connection get db =>
      _connection ??= throw Exception('Database connection not initialized');

  /// Connect to the database with the given credentials
  Future<void> connect() async {
    try {
      _connection = await Connection.open(
        _endpoint,
        settings: const ConnectionSettings(
          sslMode: SslMode.disable,
        ),
      );

      log('Database connection successful');
    } catch (e) {
      log('Database connection failed: $e');
    }
  }

  /// Close the database connection
  Future<void> close() => _connection!.close();
}

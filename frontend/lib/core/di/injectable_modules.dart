import 'package:dio/dio.dart';
import 'package:fullstack_todo/constants/constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModules {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(baseUrl: kBaseUrl));
}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fullstack_todo/core/di/injectable_modules.dart' as _i233;
import 'package:fullstack_todo/data/data_source/todo_http_client/todos_http_client.dart'
    as _i635;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModules = _$InjectableModules();
    gh.lazySingleton<_i361.Dio>(() => injectableModules.dio);
    gh.lazySingleton<_i635.TodosHttpClient>(
      () => _i635.TodosHttpClient(gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$InjectableModules extends _i233.InjectableModules {}

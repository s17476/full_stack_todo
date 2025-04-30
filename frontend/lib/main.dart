import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_todo/core/di/injection.dart';
import 'package:fullstack_todo/presentation/blocs/cubit/todos_cubit.dart';
import 'package:fullstack_todo/presentation/pages/todos_page.dart';

void main() {
  setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: getIt<TodosCubit>()..init())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: TodosPage(),
      ),
    );
  }
}

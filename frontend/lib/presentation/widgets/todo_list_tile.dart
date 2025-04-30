import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_todo/presentation/blocs/cubit/todos_cubit.dart';

import 'package:models/models.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (val) => context.read<TodosCubit>().markCompleted(todo),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => context.read<TodosCubit>().handleTodo(todo),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => context.read<TodosCubit>().deleteTodo(todo),
          ),
        ],
      ),
    );
  }
}

// https://saileshdahal.com.np/building-a-fullstack-app-with-dartfrog-and-flutter-in-a-monorepo-part-5?source=more_series_bottom_blogs#heading-creating-maintaintodoview

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_todo/presentation/blocs/cubit/todos_cubit.dart';
import 'package:fullstack_todo/presentation/widgets/todo_list_tile.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failure != null) {
            return Center(child: Text(state.failure!.message));
          }

          if (state.todos.isEmpty) {
            return const Center(child: Text('No todos found'));
          }

          return RefreshIndicator(
            onRefresh: context.read<TodosCubit>().refresh,
            child: ListView.builder(
              itemCount: state.todos.length,

              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return TodoListTile(todo: todo);
              },
            ),
          );
        },
      ),
    );
  }
}

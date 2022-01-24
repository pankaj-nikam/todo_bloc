import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/services/todo_service.dart';
import 'package:todo_bloc/todos/bloc/bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  final String userName;

  const TodosPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(userName)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.tasks[index].task),
                      trailing: Checkbox(
                        value: state.tasks[index].completed,
                        onChanged: (value) {},
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: state.tasks.length);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

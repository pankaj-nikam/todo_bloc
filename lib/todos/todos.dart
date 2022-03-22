import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/services/todo_service.dart';
import 'package:todo_bloc/todos/bloc/bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  final String userName;

  const TodosPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodosBloc(RepositoryProvider.of<TodoService>(context))
            ..add(LoadTodosEvent(userName)),
      child: Scaffold(
        floatingActionButton:
            BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
          return FloatingActionButton(
            onPressed: () async {
              final result = await showDialog<String>(
                context: context,
                builder: (context) => const Dialog(
                  child: CreateNewTask(),
                ),
              );
              if (result != null) {
                BlocProvider.of<TodosBloc>(context).add(AddTodoEvent(result));
              }
            },
            child: const Icon(Icons.add),
            tooltip: 'Add a new todo',
          );
        }),
        appBar: AppBar(
          title: const Text("Todo List"),
        ),
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.tasks[index].task),
                    trailing: Checkbox(
                      value: state.tasks[index].completed,
                      onChanged: (value) {
                        BlocProvider.of<TodosBloc>(context)
                            .add(ToggleTodoEvent(state.tasks[index].task));
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.tasks.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('What task do you want to create?'),
        TextField(
          controller: _inputController,
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop(_inputController.text);
          },
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        )
      ],
    );
  }
}

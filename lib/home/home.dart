import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/services/authentication_service.dart';
import 'package:todo_bloc/services/todo_service.dart';
import 'package:todo_bloc/todos/todos.dart';

import 'bloc/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final userNameField = TextEditingController();
  final passwordField = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to todo app"),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return TodosPage(
                    userName: state.userName,
                  );
                },
              ));
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "User name"),
                    controller: userNameField,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    controller: passwordField,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(
                            LoginEvent(userNameField.text, passwordField.text));
                      },
                      child: const Text('Login'))
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

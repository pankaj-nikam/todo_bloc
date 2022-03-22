part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodosEvent {
  final String task;

  const AddTodoEvent(this.task);

  @override
  List<Object> get props => [task];
}

class LoadTodosEvent extends TodosEvent {
  final String userName;

  const LoadTodosEvent(this.userName);

  @override
  List<Object> get props => [userName];
}

class ToggleTodoEvent extends TodosEvent {
  final String task;

  const ToggleTodoEvent(this.task);

  @override
  List<Object> get props => [task];
}

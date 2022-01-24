part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodosEvent {
  final String userName;

  const LoadTodosEvent(this.userName);

  @override
  List<Object> get props => [userName];
}

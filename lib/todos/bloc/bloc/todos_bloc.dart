import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/model/task.dart';
import 'package:todo_bloc/services/todo_service.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasksForUser(event.userName);
      emit(TodosLoadedState(todos, event.userName));
    });

    on<AddTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      _todoService.addTask(event.task, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<ToggleTodoEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      _todoService.updateTask(
        event.task,
        currentState.username,
      );
      add(LoadTodosEvent(currentState.username));
    });
  }
}

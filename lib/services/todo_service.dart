import 'package:hive/hive.dart';
import 'package:todo_bloc/model/task.dart';

class TodoService {
  late Box<Task> _tasks;
  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>("tasks");

    if (_tasks.isEmpty) {
      _tasks.add(Task("user1", "Something todo", false));
      _tasks.add(Task("user1", "Something todo 2", false));
      _tasks.add(Task("user1", "Something todo 3", false));
      _tasks.add(Task("user1", "Something todo 4", true));

      _tasks.add(Task("user2", "Something new todo", false));
      _tasks.add(Task("user2", "Something new todo 2", false));
      _tasks.add(Task("user2", "Something new todo 3", false));
      _tasks.add(Task("user2", "Something new todo 4", true));
    }
  }

  List<Task> getTasksForUser(String userName) {
    final tasks = _tasks.values.where((element) => element.user == userName);
    return tasks.toList();
  }

  Future<void> addTask(final String task, final String userName) async {
    await _tasks.add(Task(userName, task, false));
  }

  Future<void> removeTask(final String task, final String userName) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == userName);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String userName) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == userName);
    final index = taskToEdit.key as int;
    await _tasks.put(index, Task(userName, task, !taskToEdit.completed));
  }
}

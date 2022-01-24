import 'package:hive_flutter/adapters.dart';
import 'package:todo_bloc/model/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>("usersBox");

    if (_users.isEmpty) {
      await _users.add(User('user1', 'password'));
      await _users.add(User('user2', 'password2'));
    }
  }

  Future<String?> authenticateUser(
      final String userName, final String password) async {
    final success = _users.values.any((element) =>
        element.password == password && element.userName == userName);
    if (success) {
      return userName;
    }
    return null;
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/services/authentication_service.dart';
import 'package:todo_bloc/services/todo_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emitter) async {
      final result =
          await _auth.authenticateUser(event.userName, event.password);
      if (result != null) {
        emitter(SuccessfulLoginState(result));
        emitter(HomeInitial());
      }
    });

    on<RegisterAccountEvent>((event, emitter) async {
      final result = await _auth.createUser(event.userName, event.password);
      switch (result) {
        case UserCreationResult.success:
          emitter(SuccessfulLoginState(event.userName));
          emitter(const HomeInitial());
          break;
        case UserCreationResult.userAlreadyExists:
          emitter(const HomeInitial(error: 'User already exists.'));
          break;
        case UserCreationResult.failure:
          emitter(const HomeInitial(
              error: 'There was an issue creating an account.'));
          break;
        default:
      }
    });

    on<RegisterServicesEvent>((event, emitter) async {
      await _auth.init();
      await _todo.init();

      emitter(HomeInitial());
    });
  }
}

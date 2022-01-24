part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class SuccessfulLoginState extends HomeState {
  final String userName;

  const SuccessfulLoginState(this.userName);

  @override
  List<Object?> get props => [userName];
}

class RegisteringServicesState extends HomeState {
  @override
  List<Object?> get props => [];
}

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String password;
  final String username;

  const LoginUserEvent(
      {required this.context, required this.password, required this.username});
}

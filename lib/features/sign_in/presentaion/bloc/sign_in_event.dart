part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInUserEvent extends SignInEvent {
  final BuildContext context;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;
  final String password;

  const SignInUserEvent(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.password,
      required this.context});
}

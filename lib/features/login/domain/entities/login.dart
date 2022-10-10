import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String username;
  final String password;

  LoginModel({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

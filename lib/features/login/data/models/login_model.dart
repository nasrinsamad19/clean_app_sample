// import 'package:clean_app_sample/features/login/domain/entities/login.dart';

// class LoginModel extends Login {
//   LoginModel({
//     required String username,
//     required String password,
//   }) : super( username, password);

//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//       username: json['username'],
//       password: json['password'],
//     );
//   }

//    Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'password': password,
//     };
//   }
// }

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String user;

  User({
    required this.id,
    required this.user,
  });

  @override
  List<Object> get props => [id, user];
}

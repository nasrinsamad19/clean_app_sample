// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:clean_app_sample/core/error/exception.dart';
// import 'package:clean_app_sample/features/login/data/models/login_model.dart';

// abstract class LoginRemoteDataSource {
//   /// Calls the http://numbersapi.com/{number} endpoint.
//   ///
//   /// Throws a [ServerException] for all error codes.
//   Future<LoginModel> login(String username, String password);
// }

// class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
//   final http.Client client;

//   LoginRemoteDataSourceImpl({required this.client});

//   // @override
//   // Future<NumberTriviaModel> getRandomNumberTrivia() =>
//   //     _getTriviaFromUrl('http://numbersapi.com/random');

//   Future<LoginModel> _getLoginUrl(String url) async {
//     final response = await client.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       return LoginModel.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<LoginModel> login(String username, String password) =>
//       _getLoginUrl('http://numbersapi.com/');
// }

import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';

class LoginUser {
  Future<User?> login(LoginModel login) async {
    if (login.username == "username" && login.password == "password") {
      return User(id: 1, user: "admin");
    } else {
      return null;
    }
  }
}

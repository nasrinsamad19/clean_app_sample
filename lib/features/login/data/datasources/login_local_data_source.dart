// import 'dart:convert';

// import 'package:clean_app_sample/core/error/exception.dart';
// import 'package:clean_app_sample/features/login/data/models/login_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// abstract class LoginLocalDataSource {
//   /// Gets the cached [NumberTriviaModel] which was gotten the last time
//   /// the user had an internet connection.
//   ///
//   /// Throws [NoLocalDataException] if no cached data is present.
//   Future<LoginModel> getLastLogin();

//   Future<void> cacheLogin(LoginModel triviaToCache);
// }

// const CACHED_LOGIN = 'CACHED_LOGIN';

// class LoginLocalDataSourceImpl implements LoginLocalDataSource {
//   final SharedPreferences sharedPreferences;

//   LoginLocalDataSourceImpl({required this.sharedPreferences});

//   @override
//   Future<LoginModel> getLastLogin() {
//     final jsonString = sharedPreferences.getString(CACHED_LOGIN);
//     if (jsonString != null) {
//       return Future.value(LoginModel.fromJson(json.decode(jsonString)));
//     } else {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void> cacheLogin(LoginModel LoginToCache) {
//     return sharedPreferences.setString(
//       CACHED_LOGIN,
//       json.encode(LoginToCache.toJson()),
//     );
//   }
// }

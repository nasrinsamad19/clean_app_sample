// import 'dart:async';
// import 'dart:io';

// import 'package:clean_app_sample/core/platform/network_info.dart';
// import 'package:clean_app_sample/features/sign_in/data/datasources/sign_in_local_datasources.dart';
// import 'package:clean_app_sample/features/sign_in/data/datasources/sign_in_remote_datasources.dart';
// import 'package:clean_app_sample/features/sign_in/domain/entities/sign_in_entities.dart';
// import 'package:clean_app_sample/core/error/failure.dart';
// import 'package:clean_app_sample/features/sign_in/domain/repo/sign_in_repo.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../core/error/exception.dart';

// class SignInRepoImp implements SignInRepositories {
//   //final SignInLocalDataSource signInLocalDataSource;
//   final SignInRemoteDataSource signInRemoteDataSource;
//   final NetworkInfo networkInfo;

//   SignInRepoImp({
//     //required this.signInLocalDataSource,
//     required this.signInRemoteDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, SignInEntity>> signInRequest(
//       {required String email,
//       required String firstName,
//       required String lastName,
//       required String phoneNumber,
//       required String dateOfBirth,
//       required String password}) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final remoteSignIn = await signInRemoteDataSource.signIn(
//           email: email,
//           firstName: firstName,
//           lastName: lastName,
//           phoneNumber: phoneNumber,
//           dateOfBirth: dateOfBirth,
//           password: password,
//         );

//         /// cache full user info
//         // signInLocalDataSource.cacheUserData(remoteSignIn);

//         return Right(remoteSignIn);
//       } on ServerException {
//         return Left(ServerFailure());
//       } on TimeoutException {
//         return Left(TimeoutFailure());
//       } on SocketException {
//         return Left(SocketFailure());
//       } on FormatException {
//         return Left(FormatFailure());
//       } on OfflineException {
//         return Left(OfflineFailure());
//       } on InvalidInputException {
//         return Left(InvalidInputFailure());
//       }
//     } else {
//       return left(OfflineFailure());
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/login/presentation/pages/login_page.dart';
import 'package:clean_app_sample/features/sign_in/domain/entities/sign_in_entities.dart';
import 'package:clean_app_sample/features/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUsecase signInUsecase;

  SignInBloc({required this.signInUsecase}) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is SignInUserEvent) {
        emit(LoadingSignState());
        await signInUsecase(
                email: event.email,
                firstName: event.firstName,
                lastName: event.lastName,
                phoneNumber: event.phoneNumber,
                dateOfBirth: event.dateOfBirth.toString(),
                password: event.password)
            .then((value) => emit(_mapFailureOrSigninToState(
                value, event.firstName, event.context)));
      }
    });
  }
}

SignInState _mapFailureOrSigninToState(
    Either<Failure, SignInEntity> either, String name, BuildContext context) {
  return either.fold(
    (failure) =>
        ErrorSignState(message: _mapFailureToMessage(failure, context)),
    (auth) => LoadedSignState(signInEntity: auth, name: name),
  );
}

String _mapFailureToMessage(Failure failure, context) {
  debugPrint(failure.runtimeType.toString());
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'serverFailureError';
    case OfflineFailure:
      return 'offline';
    case InvalidCredentials:
      return 'UnAuthorized';
    case InvalidInputFailure:
      return 'wentWrong';
    case ReLoginFailure:
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      return 'session';
    default:
      return 'offline';
  }
}

import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';
import 'package:clean_app_sample/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_app_sample/features/login/presentation/dto/dto.dart';
import 'package:clean_app_sample/features/login/presentation/pages/login_page.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(InitialLoginState()) {
    on<LoginEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoginUserEvent) {
        emit(LoadingLoginState());
        await loginUseCase(username: event.username, password: event.password)
            .then((value) => emit(_mapFailureOrLoginToState(
                value, event.username, event.context)));
      }
    });
  }
  LoginState _mapFailureOrLoginToState(Either<Failure, LogInEntity> either,
      String username, BuildContext context) {
    return either.fold(
      (failure) =>
          ErrorLoginState(message: _mapFailureToMessage(failure, context)),
      (auth) => LoadedLoginState(logInEntity: auth, username: username),
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
}

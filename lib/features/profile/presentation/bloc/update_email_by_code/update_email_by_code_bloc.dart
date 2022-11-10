import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_email_by_code.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/pages/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'update_email_by_code_event.dart';
part 'update_email_by_code_state.dart';

class UpdateEmailByCodeBloc
    extends Bloc<UpdateEmailByCodeEvent, UpdateEmailByCodeState> {
  UpdateEmailByCode updateEmailByCode;
  UpdateEmailByCodeBloc(this.updateEmailByCode)
      : super(UpdateEmailByCodeInitial()) {
    on<UpdateEmailByCodeEvent>((event, emit) async {
      if (event is UpdateEmailByCodeProfileEvent) {
        emit(LoadingUpdateEmailByCodeState());
        final unitOrFailure =
            await updateEmailByCode(event.code, event.emailToken);
        emit(_mapUnitOrFailureState(unitOrFailure, event.context));
      }
    });
  }
  UpdateEmailByCodeState _mapUnitOrFailureState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold((failure) {
      return ErrorUpdateEmailByCodeState(
          message: _mapFailureToMessage(failure, context));
    },
        (image) => SuccessUpdateEmailByCodeState(
            message: 'Email Changed Sucessfully'));
  }

  String _mapFailureToMessage(Failure failure, BuildContext context) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'serverFailureError';
      case EmptyCacheFailure:
        return 'emptyCacheFailure';
      case OfflineFailure:
        return 'offline';
      case EmailAlreadyExistFailure:
        return 'EmailAlreadyExistFailure';
      case PhoneAlreadyExistFailure:
        return 'PhoneAlreadyExistFailure';
      case UsernameAlreadyExistFailure:
        return 'UsernameAlreadyExistFailure';
      case EmailTokenFailure:
        return 'EmailTokenFailure';
      case IncorrectPasswordFailure:
        return 'IncorrectPasswordFailure';
      case IncorrectCodeFailure:
        return 'IncorrectCodeFailure';
      case ReLoginFailure:
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => SiginPage()));
        return 'session';
      default:
        return 'unexpectedError';
    }
  }
}

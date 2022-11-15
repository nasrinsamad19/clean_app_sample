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
        return 'server Failure';
      case EmptyCacheFailure:
        return 'empty Cache';
      case OfflineFailure:
        return 'offline';
      case EmailAlreadyExistFailure:
        return 'Email Already Exist';
      case PhoneAlreadyExistFailure:
        return 'Phone Already Exist';
      case UsernameAlreadyExistFailure:
        return 'Username Already Exist';
      case EmailTokenFailure:
        return 'Email Token Expired';
      case IncorrectPasswordFailure:
        return 'Incorrect Password';
      case IncorrectCodeFailure:
        return 'Incorrect Code';
      case ReLoginFailure:
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => SiginPage()));
        return 'session Eroror';
      default:
        return 'unexpected Error';
    }
  }
}

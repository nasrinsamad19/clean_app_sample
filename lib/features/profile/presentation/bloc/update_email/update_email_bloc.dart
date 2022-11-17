import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_email.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/pages/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'update_email_event.dart';
part 'update_email_state.dart';

class UpdateEmailBloc extends Bloc<UpdateEmailEvent, UpdateEmailState> {
  UpdateEmailUseCase updateEmailUseCase;
  UpdateEmailBloc(this.updateEmailUseCase) : super(UpdateEmailInitial()) {
    on<UpdateEmailEvent>((event, emit) async {
      if (event is UpdateProfileEmailEvent) {
        emit(LoadingUpdateEmailState());
        final emailTokenOrFailure = await updateEmailUseCase(event.newEmail);
        emit(_mapUnitOrFailureState(emailTokenOrFailure, event.context));
      }
    });
  }
  UpdateEmailState _mapUnitOrFailureState(
      Either<Failure, String> either, BuildContext context) {
    return either.fold((failure) {
      return ErrorUpdateEmailState(
          message: _mapFailureToMessage(failure, context));
    },
        (emailToken) => SuccessUpdateEmailState(
            message: 'Email code sented', emailToken: emailToken));
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

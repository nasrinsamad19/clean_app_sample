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
            message: 'Image Uploaded', emailToken: emailToken));
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

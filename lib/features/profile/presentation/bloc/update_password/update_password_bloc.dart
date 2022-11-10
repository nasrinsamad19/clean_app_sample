import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/pages/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordUseCase updatePasswordUseCase;
  UpdatePasswordBloc(this.updatePasswordUseCase)
      : super(UpdatePasswordInitial()) {
    on<UpdatePasswordEvent>((event, emit) async {
      if (event is UpdatePasswordProfileEvent) {
        emit(LoadingUpdatePasswordState());
        final unitOrFailure = await updatePasswordUseCase(
            event.currentPassword, event.newPassword);
        emit(_mapUnitOrFailureState(unitOrFailure, event.context));
      }
    });
  }

  UpdatePasswordState _mapUnitOrFailureState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold((failure) {
      return ErrorUpdatePasswordState(
          message: _mapFailureToMessage(failure, context));
    }, (profile) {
      return SuccessUpdatePasswordState(
          message: "Password Updated Successfully");
    });
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

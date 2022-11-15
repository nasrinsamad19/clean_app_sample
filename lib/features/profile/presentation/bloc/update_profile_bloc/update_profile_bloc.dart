import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/pages/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/profile.dart';
import '../../../domain/usecases/update_profile_info_use_case.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileInfoUseCase updateProfileInfoUseCase;
  UpdateProfileBloc(this.updateProfileInfoUseCase)
      : super(UpdateProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) async {
      if (event is UpdateProfileInfoEvent) {
        emit(const LoadingUpdateProfileInfoState());
        final unitOrFailure = await updateProfileInfoUseCase(event.profile);
        emit(_mapUnitOrFailureState(unitOrFailure, event.context));
      }
    });
  }

  UpdateProfileState _mapUnitOrFailureState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold((failure) {
      return ErrorUpdateProfileInfoState(
          message: _mapFailureToMessage(failure, context));
    }, (profile) {
      return const SuccessUpdateProfileInfoState(
          message: "Profile Updated Successfully");
    });
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
        return 'EmailTokenFailure';
      case IncorrectPasswordFailure:
        return 'Incorrect Password';
      case IncorrectCodeFailure:
        return 'Incorrect Code';
      case ReLoginFailure:
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => SiginPage()));
        return 'session';
      default:
        return 'unexpectedError';
    }
  }
}

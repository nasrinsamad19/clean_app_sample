import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_image_use_case.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/pages/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'update_image_event.dart';
part 'update_image_state.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  UpdateProfileImageUseCase updateProfileImageUseCase;
  UpdateImageBloc(this.updateProfileImageUseCase)
      : super(UpdateImageInitial()) {
    on<UpdateImageEvent>((event, emit) async {
      if (event is UpdateProfileImageEvent) {
        emit(LoadingUpdateImageState());
        final imageOrFailure = await updateProfileImageUseCase(event.image);
        emit(_mapUnitOrFailureState(imageOrFailure, event.context));
      }
    });
  }

  UpdateImageState _mapUnitOrFailureState(
      Either<Failure, String> either, BuildContext context) {
    return either.fold((failure) {
      return ErrorUpdateImageState(
          message: _mapFailureToMessage(failure, context));
    }, (image) => SuccessUpdateImageState(message: 'Image Uploaded'));
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

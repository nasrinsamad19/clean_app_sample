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

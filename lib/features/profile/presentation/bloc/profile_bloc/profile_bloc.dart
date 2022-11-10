import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/pages/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/get_profile_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc(this.getProfileUseCase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileEvent) {
        emit(const LoadingGetProfileState());
        final profileInfoOrFailure = await getProfileUseCase();
        emit(_mapProfileOrFailureState(profileInfoOrFailure, event.context));
      }
    });
  }

  ProfileState _mapProfileOrFailureState(
      Either<Failure, Profile> either, BuildContext context) {
    return either.fold((failure) {
      return ErrorGetProfileState(
          message: _mapFailureToMessage(failure, context));
    }, (profile) {
      return SuccessGetProfileState(profile: profile);
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

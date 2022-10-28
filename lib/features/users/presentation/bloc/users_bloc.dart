import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/users/data/model/users_model.dart';
import 'package:clean_app_sample/features/users/domain/entities/users.dart';
import 'package:clean_app_sample/features/users/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'users_event.dart';
part 'users_state.dart';

int page = 1;

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersBloc({required this.getUsersUseCase}) : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is GetUsersEvent) {
        LoadedUsersState loadedUserState = state as LoadedUsersState;
        if (!loadedUserState.hasReachedMax) {
          final failureOrSites =
              await getUsersUseCase(page: (++page).toString());
          emit(_mapDeviceToState(state, failureOrSites, event.context));
        }
      } else if (event is RefreshUsersEvent) {
        page = 1;
        emit(UsersInitial());

        await getUsersUseCase(page: (page).toString()).then(
            (value) => emit(_mapDeviceToState(state, value, event.context)));
      }
    });
  }
  UsersState _mapDeviceToState(UsersState state,
      Either<Failure, UsersEntity> either, BuildContext context) {
    try {
      print(state);
      if (state is UsersInitial) {
        return either.fold((failure) => const ErrorUserState(), (newUsers) {
          return newUsers.userData.users.length < 10
              ? LoadedUsersState(
                  hasReachedMax: true,
                  users: newUsers.userData.users,
                )
              : LoadedUsersState(
                  users: newUsers.userData.users,
                );
        });
      }

      LoadedUsersState loadedUsersState = state as LoadedUsersState;

      return either.fold((failure) => const ErrorUserState(), (newUsers) {
        if (newUsers.userData.users.isEmpty) {
          return loadedUsersState.copyWith(hasReachedMax: true);
        } else {
          return loadedUsersState.copyWith(
              devices: loadedUsersState.users + newUsers.userData.users);
        }
      });
    } on Exception {
      return const ErrorUserState();
    }
  }
}

part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];
}

class LoadingUsersState extends UsersState {
  @override
  List<Object> get props => [];
}

class LoadedUsersState extends UsersState {
  final List<User> users;
  final bool hasReachedMax;
  const LoadedUsersState({required this.users, this.hasReachedMax = false});
  LoadedUsersState copyWith({
    List<User>? devices,
    bool? hasReachedMax,
  }) {
    return LoadedUsersState(
      users: devices ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [users, hasReachedMax];
}

class ErrorUserState extends UsersState {
  const ErrorUserState();

  @override
  List<Object> get props => [];
}

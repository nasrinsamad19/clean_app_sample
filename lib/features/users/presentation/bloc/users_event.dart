part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent {
  final BuildContext context;

  const GetUsersEvent({
    required this.context,
  });
}

class RefreshUsersEvent extends UsersEvent {
  final BuildContext context;

  const RefreshUsersEvent({
    required this.context,
  });
}

part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();
}

class UpdatePasswordProfileEvent extends UpdatePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final BuildContext context;

  UpdatePasswordProfileEvent(
      {required this.currentPassword,
      required this.newPassword,
      required this.context});

  @override
  List<Object> get props => [currentPassword, newPassword, context];
}

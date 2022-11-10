part of 'update_email_bloc.dart';

abstract class UpdateEmailEvent extends Equatable {
  const UpdateEmailEvent();
}

class UpdateProfileEmailEvent extends UpdateEmailEvent {
  final String newEmail;
  final BuildContext context;

  UpdateProfileEmailEvent({required this.newEmail, required this.context});
  @override
  List<Object> get props => [newEmail, context];
}

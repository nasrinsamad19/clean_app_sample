part of 'update_email_by_code_bloc.dart';

abstract class UpdateEmailByCodeEvent extends Equatable {
  const UpdateEmailByCodeEvent();
}

class UpdateEmailByCodeProfileEvent extends UpdateEmailByCodeEvent {
  final String code;
  final String emailToken;
  final BuildContext context;

  UpdateEmailByCodeProfileEvent(
      {required this.code, required this.emailToken, required this.context});

  @override
  List<Object> get props => [code, emailToken, context];
}

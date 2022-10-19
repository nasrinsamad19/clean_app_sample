import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  final String message;

  const SignInEntity({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

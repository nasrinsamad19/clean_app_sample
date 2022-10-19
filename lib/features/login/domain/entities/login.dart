import 'package:equatable/equatable.dart';

class LogInEntity extends Equatable {
  final String message;

  const LogInEntity({required this.message});

  @override
  List<Object?> get props => [message];
}

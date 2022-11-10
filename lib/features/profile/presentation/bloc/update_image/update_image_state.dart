part of 'update_image_bloc.dart';

abstract class UpdateImageState extends Equatable {
  const UpdateImageState();
}

class UpdateImageInitial extends UpdateImageState {
  @override
  List<Object> get props => [];
}

class SuccessUpdateImageState extends UpdateImageState {
  final String message;

  SuccessUpdateImageState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorUpdateImageState extends UpdateImageState {
  @override
  final String message;

  ErrorUpdateImageState({required this.message});

  List<Object?> get props => [message];
}

class LoadingUpdateImageState extends UpdateImageState {
  LoadingUpdateImageState();
  @override
  List<Object?> get props => [];
}

part of 'update_image_bloc.dart';

abstract class UpdateImageEvent extends Equatable {
  const UpdateImageEvent();
}

class UpdateProfileImageEvent extends UpdateImageEvent {
  final BuildContext context;
  final XFile image;

  UpdateProfileImageEvent({required this.context, required this.image});
  @override
  List<Object> get props => [image, context];
}

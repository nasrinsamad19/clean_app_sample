import 'package:clean_app_sample/features/users/data/model/users_model.dart';
import 'package:equatable/equatable.dart';

class UsersEntity extends Equatable {
  final UserData userData;

  const UsersEntity({required this.userData});

  @override
  List<Object?> get props => [userData];
}

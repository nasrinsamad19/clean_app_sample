import 'package:equatable/equatable.dart';

class Profile extends Equatable{
  final String username;
  final String phone;
  final String email;
  final String image;
  final String userType;
  final String userTypeId;
  final String companyId;
  final String companyName;

  const Profile({
    required this.username,required this.phone,required this.email,required this.image,
    required this.userType,required this.userTypeId,required this.companyId,required this.companyName
  });
  @override
  List<Object?> get props => [username, phone, email, image,userType,userTypeId,companyId,companyName];
}
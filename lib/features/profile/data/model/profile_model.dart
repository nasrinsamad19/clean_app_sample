import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel(
      {required super.username,
      required super.phone,
      required super.email,
      required super.image,
      required super.userType,
      required super.userTypeId,
      required super.companyId,
      required super.companyName});
  static ProfileModel fromJson(json) {
    return ProfileModel(
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      userType: json['userTypeInfo']['userType'],
      userTypeId: json['userTypeInfo']['userTypeId'].toString(),
      companyId: json['userCompanyInfo']['companyId'].toString(),
      companyName: json['userCompanyInfo']['companyName'],
    );
  }
}

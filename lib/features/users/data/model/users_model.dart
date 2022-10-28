import 'package:clean_app_sample/features/users/domain/entities/users.dart';

class Users extends UsersEntity {
  const Users({
    required super.userData,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(userData: UserData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    final date = <String, dynamic>{};
    date['data'] = userData.toJson();
    return date;
  }
}

class UserData {
  UserData({
    required this.users,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });
  late final List<User> users;
  late final int totalDocs;
  late final int limit;
  late final int totalPages;
  late final int page;
  late final int pagingCounter;
  late final bool hasPrevPage;
  late final bool hasNextPage;
  late final int? prevPage;
  late final int? nextPage;

  UserData.fromJson(Map<String, dynamic> json) {
    users = List.from(json['users']).map((e) => User.fromJson(e)).toList();
    totalDocs = json['totalDocs'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    page = json['page'];
    pagingCounter = json['pagingCounter'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prevPage = json['prevPage'] ?? 0;
    nextPage = json['nextPage'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['docs'] = users.map((e) => e.toJson()).toList();
    data['totalDocs'] = totalDocs;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    data['page'] = page;
    data['pagingCounter'] = pagingCounter;
    data['hasPrevPage'] = hasPrevPage;
    data['hasNextPage'] = hasNextPage;
    data['prevPage'] = prevPage;
    data['nextPage'] = nextPage;
    return data;
  }
}

class User {
  User(
      {required this.userId,
      required this.username,
      required this.phone,
      required this.email,
      required this.userTypeInfo,
      required this.siteId,
      required this.companyInfo,
      required this.accountStatus,
      required this.image,
      required this.lastLogin});
  late final int userId;
  late final String username;
  late final String phone;
  late final String email;
  late final bool accountStatus;
  late final String? image;
  late final UserTypeInfo userTypeInfo;
  late final CompanyInfo? companyInfo;
  late final String lastLogin;
  late final List<int> siteId;
  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'] ?? '';
    accountStatus = json['account_status'];
    image = json['image'] ?? '';
    userTypeInfo = UserTypeInfo.fromJson(json['userTypeInfo']);
    companyInfo = json['companyInfo'] == null
        ? null
        : CompanyInfo.fromJson(json['companyInfo']);
    lastLogin = json['lastLogin'];
    siteId = List.from(json['siteId']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['phone'] = phone;
    data['email'] = email;
    data['userTypeInfo'] = userTypeInfo.toJson();

    return data;
  }
}

class UserTypeInfo {
  UserTypeInfo({
    required this.userTypeId,
    required this.userType,
  });
  late final String userType;
  late final int userTypeId;

  UserTypeInfo.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    userTypeId = json['userTypeId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userType'] = userType;
    data['userTypeId'] = userTypeId;
    return data;
  }
}

class CompanyInfo {
  CompanyInfo({
    required this.companyName,
    required this.companyId,
  });
  late final String companyName;
  late final int companyId;

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['companyName'] = companyName;
    data['companyId'] = companyId;
    return data;
  }
}

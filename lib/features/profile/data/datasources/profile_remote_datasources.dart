import 'dart:convert';
import 'dart:io';

import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/servers/server_domain.dart';
import 'package:clean_app_sample/features/profile/data/model/profile_model.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_email_by_code.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfileInfo(String token);

  Future<Unit> updateProfileInfo(String token, Profile profile);

  Future<String> updateImage(String token, XFile image);

  Future<String> updateEmail(String token, String email);
  Future<Unit> updateEmailByCode(
    String token,
    String emailToken,
    String code,
  );

  Future<Unit> updatePassword(
      String token, String currentPassword, String newPassword);
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  final http.Client client;
  ProfileRemoteDataSourceImp(this.client);
  @override
  Future<Profile> getProfileInfo(String token) async {
    final response = await client.get(Uri.parse('$userUrl/profile/show'),
        headers: {
          'Authorization': 'token $token',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 200) {
      final ProfileModel profile =
          ProfileModel.fromJson(json.decode(response.body));
      return profile;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updateEmail(String token, String email) async {
    final response =
        await client.post(Uri.parse('$userUrl/reset/email/'), headers: {
      'Authorization': 'token $token',
    }, body: {
      "newEmail": email
    });
    if (response.statusCode == 200) {
      var emailToken = json.decode(response.body)['token'];
      return emailToken;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else if (response.statusCode == 452) {
      throw EmailAlreadyExistException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateEmailByCode(
      String token, String emailToken, String code) async {
    final response =
        await client.post(Uri.parse('$userUrl/reset/email-change/'), headers: {
      'Authorization': 'token $token',
    }, body: {
      "token": emailToken,
      "code": code,
    });
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else if (response.statusCode == 458) {
      throw IncorrectCodeException();
    } else if (response.statusCode == 470) {
      throw EmailTokenException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePassword(
      String token, String currentPassword, String newPassword) async {
    final response = await client
        .put(Uri.parse('$userUrl/profile/update-password/'), headers: {
      'Authorization': 'token $token',
    }, body: {
      "currentPassword": currentPassword,
      "newPassword": newPassword
    });
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else if (response.statusCode == 458) {
      throw IncorrectPasswordException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updateImage(String token, XFile image) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse('$userUrl/profile/update-image/'))
      ..files.add(await http.MultipartFile.fromBytes(
          'image', File(image.path).readAsBytesSync(),
          filename: image.path.split('/').last,
          contentType: MediaType('image', 'jpg')));

    final headers = {
      'Content-type': 'multipart/form-data',
      'Authorization': 'token $token',
    };
    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());

    print(response.statusCode);
    if (response.statusCode == 200) {
      String imageUrl = json.decode(response.body)['image'];
      return imageUrl;
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProfileInfo(String token, Profile profile) async {
    final response =
        await client.put(Uri.parse('$userUrl/profile/update-info'), headers: {
      'Authorization': 'token $token',
    }, body: {
      "phone": profile.phone,
      "email": profile.email,
      "username": profile.username
    });
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 452) {
      String responseCode = json.decode(response.body)['field'];
      if (responseCode == "email") {
        throw EmailAlreadyExistException();
      } else if (responseCode == "phone") {
        throw PhoneAlreadyExistException();
      } else {
        throw UsernameAlreadyExistException();
      }
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else {
      throw ServerException();
    }
  }
}

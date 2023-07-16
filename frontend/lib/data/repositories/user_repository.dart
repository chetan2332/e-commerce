import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/core/api.dart';
import 'package:frontend/data/model/user/user_model.dart';

class UserRepository {
  final _api = Api().sendRequest;

  Future<UserModel> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.post('/user/createAccount',
          data: jsonEncode({
            "email": email,
            "password": password,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // convert raw data to model
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.post('/user/signIn',
          data: jsonEncode({
            "email": email,
            "password": password,
          }));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // convert raw data to model
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}

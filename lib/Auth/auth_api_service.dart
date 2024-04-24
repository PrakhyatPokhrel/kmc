import 'package:dio/dio.dart';
import 'package:kmc/components/custom_api_service.dart';
import 'package:kmc/config/url.dart';

abstract class AuthApiService {
  static Future<int> postLoginCredentials(
      {required String email, required String password}) async {
    try {
      Response response = await CustomApiService().post(
        CustomURL.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data["data"];
    } catch (e) {
      throw CustomApiService.handleException(e,
          message: "Could not submit sifarish");
    }
  }
}

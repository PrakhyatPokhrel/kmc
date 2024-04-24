import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getPackage;
import 'package:kmc/Auth/login.dart';
import 'package:kmc/components/custom_exception.dart';
import 'package:kmc/config/replaceable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomApiService {
  static final CustomApiService _instance = CustomApiService._internal();
  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  Options _cacheOptions =
      buildCacheOptions(Duration(days: 30), forceRefresh: true);

  Dio _dio = Dio(BaseOptions(baseUrl: Config.base_url)); // create Dio instance
  SharedPreferences? _prefs; // shared preferences instance
  String? _authToken; // store bearer token

  factory CustomApiService() {
    return _instance;
  }

  CustomApiService._internal() {
    // Initialize shared preferences instance
    SharedPreferences.getInstance().then((instance) {
      _prefs = instance;
      setAuthToken();
    });
    _dio.interceptors.add(_dioCacheManager.interceptor);
    // Add interceptors for handling different HTTP status codes and adding bearer token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) {
          options.headers.addAll({
            'Accept': 'application/json',
          });
          if (_authToken != null) {
            options.headers.addAll({
              'Authorization': 'Bearer $_authToken',
            });
          }
          return handler.next(options);
        },
        onError: (DioError error, handler) {
          String? customMessage;
          if (error.type == DioErrorType.response)
            switch (error.response?.statusCode) {
              case 400:
                customMessage = "Bad Request";
                break;
              case 401: // Unauthorized
                // handle 401 error
                customMessage =
                    "You are unauthorized. Please enter username and password.";
                getPackage.Get.offAll(() => Login());
                break;
              case 404:
                customMessage = "Page not Found";
                break;
              case 405:
                customMessage = "Method not Allowed";
                break;
              case 500: // Internal Server Error
                // handle 500 error
                customMessage =
                    'Internal Server Error. Please try again later.';
                break;
              case 503:
                customMessage = 'Currently the server is down';
                break;
              default:
                // handle other errors
                break;
            }
          else if (error.type == DioErrorType.other) {
            if (error.error is SocketException) {
              customMessage = 'no_internet_connection'.tr;
            }
          }
          if (customMessage != null) {
            error.error = CustomException(message: customMessage);
          }
          return handler.next(error);
        },
        onResponse: (Response response, handler) {
          switch (response.statusCode) {
            case 200: // OK
              // handle 200 response
              break;
            default:
              // handle other responses
              break;
          }
          return handler.next(response);
        },
      ),
    );
  }

  Future<void> setAuthToken() async {
    if (_prefs != null) {
      _authToken = await _prefs!.getString('token');
    }
  }

  Future<void> saveAuthToken(String token) async {
    if (_prefs != null) {
      await _prefs!.setString('token', token);
      _authToken = token;
    }
  }

  Future<Response> get(
      {required String url,
      Map<String, dynamic>? params,
      bool isCached = false}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: isCached ? _cacheOptions : null,
      );
      return response;
    } on DioError catch (e) {
      if (e.error is CustomException) {
        throw e.error;
      }
      throw CustomException(message: "");
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> post(String url,
      {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(url, data: FormData.fromMap(data));
      return response;
    } on DioError catch (e) {
      if (e.error is CustomException) {
        throw e.error;
      }
      throw CustomException(message: e.message);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> fileupload(String url,
      {required File imageFile,
      required int id,
      required String docName}) async {
    try {
      // Create FormData object
      var formData = FormData.fromMap({
        'entry_id': id.toString(),
        'doc$docName': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path),
      });

      // Send FormData object
      var response = await _dio.post(url + "s", data: formData);

      return response.statusCode;
    } on DioError catch (e) {
      if (e.error is CustomException) {
        throw e.error;
      }
      throw CustomException(message: e.message);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static CustomException handleException(dynamic e, {String? message}) {
    if (e is CustomException) {
      debugPrint(e.message);
      return e;
    } else {
      debugPrint(e.toString());
      return CustomException(
          message: message ?? "Something went wrong. Please try again later");
    }
  }
}

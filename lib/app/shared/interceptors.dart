// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final shared = await SharedPreferences.getInstance();
    final token = shared.getString('token');

    if (token != null && token != "")
      options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    else
      options.headers = {
        'Content-Type': 'application/json',
      };

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response == null || err.error == DioErrorType.connectTimeout) {
    } else if (err.error == DioErrorType.response) {
      switch (err.response!.statusCode) {
        case 401:
          break;

        default:
          break;
      }
    }
    return super.onError(err, handler);
  }

  @override
  Future<bool> refreshToken() async {
    var shared = await SharedPreferences.getInstance();
    var refreshToken = shared.getString('refreshToken');
    try {
      final data = {'refresh_token': refreshToken};
      Response response = await Dio().post(
          'https://us-central1-election-3742c.cloudfunctions.net/api/v1/refreshToken',
          data: json.encode(data));
      if (response.statusCode == 200) {
        final data = response.data['DATA']['access_token'];
        print(data);
        shared.setString('token', data);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/shared/interceptors.dart';
import 'package:election/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttp {
  final Dio client = Dio();
  CustomHttp() {
    client.options.baseUrl = baseUrl;
    client.interceptors.add(CustomInterceptors());
    client.interceptors
        .add(InterceptorsWrapper(onError: (error, handler) async {
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 401) {
        bool valid = await CustomInterceptors().refreshToken();
        print('erro aqui');
        if (valid) {
          await retry(error.requestOptions);
        }

        //
      }
      print(error.response);
      return handler.next(error);
    }));
    client.options.connectTimeout = 60000;
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    // ignore: unnecessary_new
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return await client.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:providerlearn/app/consts.dart';
import 'package:providerlearn/app/preferences.dart';

const String AppJson = "application/json";
const String Content_Type = "content-type";
const String Accept = "accept";
const String Authorization = "authorization";
const String DefaultLanguage = "language";

class DioFactory {
  AppPreferences _appPreferences ;
  DioFactory(
    this._appPreferences);
  
  Future<Dio> getDio() async {
    Dio _dio = Dio();
    String Language = await  _appPreferences.GetApplicationLanguage();
   
// 1 minute
    Map<String, String> Headers = {
      Content_Type: AppJson,
      Accept: AppJson,
      Authorization: Constants.Token,
      DefaultLanguage: Language, 
    };

    _dio.options = BaseOptions(
      baseUrl: Constants.BaseURL,
      connectTimeout:Constants.Api_TimeOut,
      receiveTimeout: Constants.Api_TimeOut,
      headers: Headers,
    );

    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return _dio;
  }
}

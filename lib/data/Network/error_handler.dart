// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:providerlearn/data/Network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so the error is from the server side or the internet connection
      failure = _handleError(error);
    } else {
      // the error is from the client side so the error is from the app
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECTION_TIME_OUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIME_OUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIME_OUT.getFailure();
    case DioErrorType.response:
      if(error.response != null  && error.response!.statusCode != null &&error.response!.statusMessage != null){
        return Failure(code:error.response!.statusCode!, message:error.response!.statusMessage!);
      }
      else{
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  SERVER_ERROR,
  CONNECTION_TIME_OUT,
  CANCEL,
  RECIEVE_TIME_OUT,
  SEND_TIME_OUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(
            code: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);

      case DataSource.NO_CONTENT:
        return Failure(
            code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORIZED:
        return Failure(
            code: ResponseCode.UNAUTHORIZED,
            message: ResponseMessage.UNAUTHORIZED);
      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);
      case DataSource.SERVER_ERROR:
        return Failure(
            code: ResponseCode.SERVER_ERROR,
            message: ResponseMessage.SERVER_ERROR);
      case DataSource.CONNECTION_TIME_OUT:
        return Failure(
            code: ResponseCode.CONNECTION_TIME_OUT,
            message: ResponseMessage.CONNECTION_TIME_OUT);
      case DataSource.CANCEL:
        return Failure(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIME_OUT:
        return Failure(
            code: ResponseCode.RECIEVE_TIME_OUT,
            message: ResponseMessage.RECIEVE_TIME_OUT);
      case DataSource.SEND_TIME_OUT:
        return Failure(
            code: ResponseCode.SEND_TIME_OUT,
            message: ResponseMessage.SEND_TIME_OUT);
      case DataSource.CACHE_ERROR:
        return Failure(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
            code: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // OK
  static const int NO_CONTENT = 201; // OK BUT No Content
  static const int BAD_REQUEST =
      400; // Bad Request (REJECTED REQUEST BY SERVER))
  static const int UNAUTHORIZED =
      401; // Unauthorized (NOT AUTHORIZED TO ACCESS THE REQUESTED RESOURCE)
  static const int FORBIDDEN =
      403; // Forbidden (ACCESS TO THE REQUESTED RESOURCE IS FORBIDDEN)
  static const int SERVER_ERROR = 500; // Internal Server Error (SERVER ERROR)

  // Local Status Codes
  static const int CONNECTION_TIME_OUT = -1; // Connection Time Out
  static const int CANCEL = -2; // Cancel
  static const int RECIEVE_TIME_OUT = -3; // Receive Time Out
  static const int SEND_TIME_OUT = -4; // Send Time Out
  static const int CACHE_ERROR = -5; // Cache Error
  static const int NO_INTERNET_CONNECTION = -6; // No Internet Connection
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success"; // OK
  static const String NO_CONTENT = "success"; // OK BUT No Content
  static const String BAD_REQUEST =
      "bad request , Try Again Later"; // Bad Request (REJECTED REQUEST BY SERVER))
  static const String UNAUTHORIZED =
      "Unauthorized User , Try again Later"; // Unauthorized (NOT AUTHORIZED TO ACCESS THE REQUESTED RESOURCE)
  static const String FORBIDDEN =
      "Forbidden request ,Try again Later"; // Forbidden (ACCESS TO THE REQUESTED RESOURCE IS FORBIDDEN)
  static const String SERVER_ERROR =
      "Something went wrong, Try Again Later"; // Internal Server Error (SERVER ERROR)

  // Local Status Codes
  static const String CONNECTION_TIME_OUT =
      "Time out error , Try Again Later"; // Connection Time Out
  static const String CANCEL =
      "request was canceled , Try Again Later"; // Cancel
  static const String RECIEVE_TIME_OUT =
      "Time out error , Try Again Later"; // Receive Time Out
  static const String SEND_TIME_OUT =
      "Time out error , Try Again Later"; // Send Time Out
  static const String CACHE_ERROR =
      " cache error , Try Again Later"; // Cache Error
  static const String NO_INTERNET_CONNECTION =
      "pls check your internet connection and  Try Again Later"; // No Internet Connection
  static const String DEFAULT = "Something went wrong, Try Again Later";
}

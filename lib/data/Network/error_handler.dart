// ignore_for_file: constant_identifier_names

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
  UNKOWN
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
  static const int UNKOWN = -7;
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
  static const String SERVER_ERROR = "Something went wrong, Try Again Later"; // Internal Server Error (SERVER ERROR)

  // Local Status Codes
  static const String CONNECTION_TIME_OUT = "Time out error , Try Again Later"; // Connection Time Out
  static const String CANCEL = "request was canceled , Try Again Later"; // Cancel
  static const String RECIEVE_TIME_OUT = "Time out error , Try Again Later"; // Receive Time Out
  static const String SEND_TIME_OUT = "Time out error , Try Again Later"; // Send Time Out
  static const String CACHE_ERROR = " cache error , Try Again Later"; // Cache Error
  static const String NO_INTERNET_CONNECTION = "pls check your internet connection and  Try Again Later"; // No Internet Connection
  static const String UNKOWN = "Something went wrong, Try Again Later";
}




import 'package:dio/dio.dart';
import 'package:providerlearn/app/consts.dart';
import 'package:providerlearn/data/Response/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constants.BaseURL)
abstract class AppServiceClient{
factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

@POST("customer/login")
Future<AuthResponse> login(
  @Field("email") String email, @Field("password") String password
  );

}


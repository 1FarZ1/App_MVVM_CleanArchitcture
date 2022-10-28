

// ignore_for_file: non_constant_identifier_names

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


// 1. first we add the request and response models
@POST("customer/forgetpassword")
Future<ForgetPasswordResponse> ForgetPassword(
  @Field("email") String email
  );
@POST("customer/register")
Future<AuthResponse> Register(
  @Field("userName") String userName,
  @Field("countryMobileCode") String countryMobileCode,
  @Field("mobileNumber") String mobileNumber,
  @Field("email") String email,
  @Field("password") String password,
  @Field("profilePicture") String profilePicture
  );

@GET("customer/home")
Future<ProfileResponse> getProfile(
  @Header("Authorization") String token
  );
}



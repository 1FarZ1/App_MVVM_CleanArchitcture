// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:providerlearn/data/Network/app_api.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);

  Future<ForgetPasswordResponse> forgetpassword(String email);

  Future<AuthResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> getHome();
  Future<StoreDetailsResponse> getStoreDetails();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(
    this._appServiceClient,
  );
  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetpassword(String email) async {
    return await _appServiceClient.ForgetPassword(email);
  }

  @override
  Future<AuthResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.Register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        registerRequest.profilePicture);
  }

  @override
  Future<HomeResponse> getHome() async {
    var response = await _appServiceClient.getHome();
    print(response.data!.banners);
    return response;
  }
  
  @override
  Future<StoreDetailsResponse> getStoreDetails()async {
    StoreDetailsResponse response = await _appServiceClient.getStoreDetails();
    print(response.id);
    return response;
  }
}

//TODO: FIX THE NULL Problem

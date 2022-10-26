// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:providerlearn/data/Network/app_api.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);

  Future<ForgetPasswordResponse> forgetpassword(String email);
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
}

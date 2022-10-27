

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:providerlearn/app/preferences.dart';
import 'package:providerlearn/data/DataSource/remote_data_source.dart';
import 'package:providerlearn/data/Network/NetworkInfo.dart';
import 'package:providerlearn/data/Network/app_api.dart';
import 'package:providerlearn/data/Network/dioFactory.dart';
import 'package:providerlearn/data/repository/repo_impl.dart';
import 'package:providerlearn/domaine/UseCase/LoginUseCase.dart';
import 'package:providerlearn/domaine/UseCase/RegisterUseCase.dart';
import 'package:providerlearn/domaine/UseCase/forgetPasswordUseCase.dart';
import 'package:providerlearn/presentation/ForgetPassword/forget_password_ViewModel.dart';
import 'package:providerlearn/presentation/login/Login_ViewModel.dart';
import 'package:providerlearn/presentation/register/Register_ViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domaine/repository/repository.dart';



// Here we used get it package to register all our dependencies in one place and use them in our app 
// and this is so handy and easy to use and maintain and access all data without buildContext

final instance = GetIt.instance;

Future<void> initAppModule() async {
// App Module is a module Where we Put All Generic Depandencies
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance<SharedPreferences>()));


  // NetWork Info Instances 
  instance.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(InternetConnectionChecker()));

  // dio Factory instance;
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));



  Dio dio =await instance<DioFactory>().getDio();
  // app service client instance;

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));


  // remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance<AppServiceClient>()));


  // Repository Instance

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<RemoteDataSource>(),instance<NetWorkInfo>())); 
}

Future<void> initLoginModule() async {
  // Login Module is a module Where we Put All Depandencies Related to Login

  if(!GetIt.I.isRegistered<LoginUseCase>()){
      instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance<Repository>()));

  instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance<LoginUseCase>()));

  }



}
//
Future<void> initForgetPasswordModule() async {
  // Login Module is a module Where we Put All Depandencies Related to Login

  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>()){
      instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance<Repository>()));

  instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance<ForgetPasswordUseCase>()));

  }
}
Future<void> initRegister() async {
  // Register Module is a module Where we Put All Depandencies Related to Register

  if(!GetIt.I.isRegistered<RegisterUseCase>()){
      instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance<Repository>()));

  instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance<RegisterUseCase>()));

  }
}
//


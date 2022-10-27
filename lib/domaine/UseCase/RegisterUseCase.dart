// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, no_leading_underscores_for_local_identifiers
import 'package:dartz/dartz.dart';
import 'package:providerlearn/data/Network/failure.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/domaine/UseCase/BaseUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Auth> {
  Repository _repo;
  RegisterUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, Auth>> excute(RegisterUseCaseInput input) async {
    return await _repo.register(RegisterRequest(
        userName: input.userName,
        countryMobileCode: input.countryMobileCode,
        mobileNumber: input.mobileNumber,
        email: input.email,
        password: input.password,
        profilePicture: input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}





//view model -> // use case -> // repository -> // repository impl   -> //remote data source -> // api client

//tools:
  // mapper 
  // extensions
  // network
  // model(objects)
  // response Objects
  // error handling and exceptions failure class   
  // request objects
  // shared pref
  //depandecy injections
  // view and resource
  // freezed retrofet(rest api) 
  // state rendering 


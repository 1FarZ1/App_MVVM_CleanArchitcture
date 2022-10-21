// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, no_leading_underscores_for_local_identifiers
import 'package:dartz/dartz.dart';
import 'package:providerlearn/data/Network/failure.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/domaine/UseCase/BaseUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Auth> {
  Repository _repo;
  LoginUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, Auth>> excute(LoginUseCaseInput input) async {
  
    return await _repo.login(
      LoginRequest(email: input.email, password: input.password)
    );

  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput({
    required this.email,
    required this.password,
  });
}

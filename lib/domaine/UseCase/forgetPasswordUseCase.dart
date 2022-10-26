import 'package:providerlearn/data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:providerlearn/domaine/UseCase/BaseUseCase.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class ForgetPasswordUseCase implements BaseUseCase<String,String>{
  Repository _repo;
  ForgetPasswordUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, String>> excute(String input) async {
      return await _repo.forgetpassword(input);
  }

}
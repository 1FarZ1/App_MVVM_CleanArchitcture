import 'package:providerlearn/data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:providerlearn/domaine/UseCase/BaseUseCase.dart';

class HomeUseCase implements BaseUseCase<dynamic,dynamic>{
  @override
  Future<Either<Failure, dynamic>> excute(input) {
    throw UnimplementedError();
  }

}
import 'package:providerlearn/data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:providerlearn/domaine/UseCase/BaseUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  Repository _repo;
  HomeUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, HomeObject>> excute(void input) async {
    var x = await _repo.getHome();
    print(x.fold((l) => print("sorry")
    , (r) => print(r.homeData?.banners)));
    return x;
  }
}

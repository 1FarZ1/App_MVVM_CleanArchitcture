import 'package:providerlearn/data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:providerlearn/domaine/UseCase/BaseUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class StoreDetailsUseCase implements BaseUseCase<void, StoreDetails> {
  Repository _repo;
  StoreDetailsUseCase(
    this._repo,
  );
  @override
  Future<Either<Failure, StoreDetails>> excute(void input) async {
    return await _repo.getStoreDetails();
  }
}


// api done
// repo done
// usecase done
// model done
// mapper done
// response done
// remote data source done
// local data source done
import 'package:providerlearn/data/DataSource/remote_data_source.dart';
import 'package:providerlearn/data/Network/NetworkInfo.dart';
import 'package:providerlearn/data/mapper/mapper.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final NetWorkInfo _netWorkInfo;

  RepositoryImpl(this._remoteDataSource, this._netWorkInfo);

  @override
  Future<Either<Failure, Auth>> login(LoginRequest loginRequest) async{

    if(await _netWorkInfo.isConnected){
     
        final response = await _remoteDataSource.login(loginRequest);
        if(response.status ==0){
          return Right(response.toDomaine());
        }
        else{
          return Left(Failure(code: 409, message: response.message ?? "Bussiness Logic"));
        }
      
    


    }
    else{
    return Left(Failure(code: 0, message: "No Internet Connection",));
  }

  }
  

}
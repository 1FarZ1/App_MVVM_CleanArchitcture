import 'package:providerlearn/data/DataSource/remote_data_source.dart';
import 'package:providerlearn/data/Network/NetworkInfo.dart';
import 'package:providerlearn/data/Network/error_handler.dart';
import 'package:providerlearn/data/Response/responses.dart';
import 'package:providerlearn/data/mapper/mapper.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:providerlearn/domaine/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetWorkInfo _netWorkInfo;

  RepositoryImpl(this._remoteDataSource, this._netWorkInfo);

  @override
  Future<Either<Failure, Auth>> login(LoginRequest loginRequest) async {
    if (await _netWorkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return Right(response.toDomaine());
        } else {
          return Left(DataSource.DEFAULT.getFailure());
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetpassword(String email) async {
    if (await _netWorkInfo.isConnected) {
      try {
        final ForgetPasswordResponse response =
            await _remoteDataSource.forgetpassword(email);

        if (response.status == 0) {
          return Right(response.toDomaine());
        } else {
          return Left(Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        print("the error is $e");
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> register(
      RegisterRequest registerRequest) async {
    if (await _netWorkInfo.isConnected) {
      try {
        final AuthResponse response =
            await _remoteDataSource.register(registerRequest);

        if (response.status == 0) {
          return Right(response.toDomaine());
        } else {
          return Left(Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        print("the error is $e");
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    if (await _netWorkInfo.isConnected) {
      try {
        var response = await _remoteDataSource.getHome();
        if (response.status == 0) {
          return Right(response.toDomaine());
        } else {
          return Left(Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        print("the error is $e");
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}

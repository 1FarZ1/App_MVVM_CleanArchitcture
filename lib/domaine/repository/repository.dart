import 'package:dartz/dartz.dart';
import 'package:providerlearn/data/Network/failure.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/domaine/models/Models.dart';

abstract class Repository {
  Future<Either<Failure,Auth>> login(LoginRequest loginRequest);
}

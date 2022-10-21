// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:providerlearn/data/Network/failure.dart';
import 'package:providerlearn/domaine/models/Models.dart';

//
abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> excute(In input);
}



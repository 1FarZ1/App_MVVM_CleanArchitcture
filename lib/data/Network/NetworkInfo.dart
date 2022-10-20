// ignore_for_file: file_names

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo{
  Future<bool> get isConnected;
}

class NetWorkInfoImpl implements NetWorkInfo{
  final InternetConnectionChecker _connectionChecker;

  NetWorkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;
}
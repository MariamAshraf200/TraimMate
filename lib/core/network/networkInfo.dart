import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Networkinfo {
  Future <bool> get isConnected ;
}

class NetworkInfoImpl extends Networkinfo{
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}
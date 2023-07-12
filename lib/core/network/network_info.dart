import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> getConnection();
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImp(this.internetConnectionChecker);
  @override
  Future<bool> getConnection() async {
    return internetConnectionChecker.hasConnection;
  }
}

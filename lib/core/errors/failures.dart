abstract class Failure {
  final String? message;
  Failure({this.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class OfflineFailure extends Failure {
  OfflineFailure({super.message});
}

class WrongDataFailure extends Failure {
  WrongDataFailure({super.message});
}
class LocationFailure extends Failure{
  final String message;

  LocationFailure(this.message);
}

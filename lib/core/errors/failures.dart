
import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{
}

class OfflineFailuer extends Failures{
  @override
  List<Object?> get props =>[];
}


class ServerFailuer extends Failures{
  @override
  List<Object?> get props =>[];
}


class WrongDataFailuer extends Failures{
  @override
  List<Object?> get props =>[];
}
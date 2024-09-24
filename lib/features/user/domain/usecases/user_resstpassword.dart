import 'package:check_weather/core/errors/failures.dart';
import 'package:check_weather/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserResstpasswordUsecas {
  final UserRepo repo ;

  UserResstpasswordUsecas({required this.repo});

  Future <Either<Failures, Unit>> call(String email) async {
     return await repo.ressetpassword(email);
  }
}
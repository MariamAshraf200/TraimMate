import 'package:check_weather/core/errors/failures.dart';
import 'package:check_weather/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserLogoutUsecase {
  final UserRepo repo;

  UserLogoutUsecase({required this.repo});
  Future<Either<Failures, Unit>> call() async {
    return await repo.logout();
  }
}

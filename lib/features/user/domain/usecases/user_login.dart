import 'package:check_weather/core/errors/failures.dart';
import 'package:check_weather/features/user/domain/entities/user_entity.dart';
import 'package:check_weather/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserLoginUsecase{
  final UserRepo repo;

  UserLoginUsecase({required this.repo});


  Future<Either<Failures, UserEntity>> call(String email,String password) async{
    return await repo.login(email, password);
  }

}


import 'package:check_weather/core/errors/failures.dart';
import 'package:check_weather/features/user/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<Failures,UserEntity>>login(String email, String password);
  Future<Either<Failures,Unit>>logout();
  Future<Either<Failures,UserEntity>>signup(String email, String name, String phone, String password);
  Future<Either<Failures,Unit>>ressetpassword(String email);
}
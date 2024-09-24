import 'package:check_weather/core/errors/exceptions.dart';
import 'package:check_weather/core/errors/failures.dart';
import 'package:check_weather/core/network/networkInfo.dart';
import 'package:check_weather/features/user/data/dataScorces/remoteDataScorce.dart';
import 'package:check_weather/features/user/domain/entities/user_entity.dart';
import 'package:check_weather/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl implements UserRepo {
  final RemoteDataScorce remoteDataScorce;
  final Networkinfo networkinfo;

  UserRepoImpl({required this.remoteDataScorce, required this.networkinfo});

  @override
  Future<Either<Failures, UserEntity>> login(
      String email, String password) async {
    if (await networkinfo.isConnected) {
      try {
        final usermodel = await remoteDataScorce.login(email, password);
        UserEntity userEntity = UserEntity(
          id: usermodel.id,
          name: usermodel.name,
          email: email,
          phone: usermodel.phone,
        );
        return Right(userEntity);
      } on ServerException {
        return Left(ServerFailuer());
      } on WrongDataException {
        return Left(WrongDataFailuer());
      }
    } else {
      return Left(OfflineFailuer());
    }
  }

  @override
  Future<Either<Failures, Unit>> logout() async {
    if (await networkinfo.isConnected) {
      try {
        await remoteDataScorce.logout();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailuer());
      }
    } else {
      return Left(OfflineFailuer());
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signup(
      String email, String name, String phone, String password) async {
    if (await networkinfo.isConnected) {
      try {
        final usermodel =
            await remoteDataScorce.signup(email, phone, name, password);
        UserEntity userEntity = UserEntity(
          id: usermodel.id,
          name: usermodel.name,
          email: email,
          phone: usermodel.phone,
        );
        return Right(userEntity);
      } on ServerException {
        return Left(ServerFailuer());
      } on WrongDataException {
        return Left(WrongDataFailuer());
      }
    } else {
      return Left(OfflineFailuer());
    }
  }

  @override
  Future<Either<Failures, Unit>> ressetpassword(String email) async {
    if (await networkinfo.isConnected) {
      try {
        await remoteDataScorce.ressetPassword(email);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailuer());
      }
    } else {
      return Left(OfflineFailuer());
    }
  }
}

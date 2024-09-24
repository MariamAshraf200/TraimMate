import 'package:check_weather/core/network/networkInfo.dart';
import 'package:check_weather/features/user/data/dataScorces/remoteDataScorce.dart';
import 'package:check_weather/features/user/domain/repositories/user_repo.dart';
import 'package:check_weather/features/user/data/reposatories/user_repo_impl.dart';
import 'package:check_weather/features/user/domain/usecases/user_login.dart';
import 'package:check_weather/features/user/domain/usecases/user_logout.dart';
import 'package:check_weather/features/user/domain/usecases/user_resstpassword.dart';
import 'package:check_weather/features/user/domain/usecases/user_signup.dart';
import 'package:check_weather/features/user/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User Authentication

  // Bloc
  sl.registerFactory(() => AuthBloc(
    loginUsecase: sl(),
    signupUsecase: sl(),
    logoutUsecase: sl(),
    resetPasswordUsecase: sl(),
  ));

  // Use Cases
  sl.registerLazySingleton(() => UserLoginUsecase(repo: sl()));
  sl.registerLazySingleton(() => UserLogoutUsecase(repo: sl()));
  sl.registerLazySingleton(() => UserResstpasswordUsecas(repo: sl()));
  sl.registerLazySingleton(() => UserSignupUsecase(repo: sl()));

  // Repository
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(
    remoteDataScorce: sl(),
    networkinfo: sl(),
  ));

  // Data sources
  sl.registerLazySingleton<RemoteDataScorce>(() => RemotedatascorceImpl(
    networkinfo: sl(),
    firebaseAuth: sl(),
    firestore: sl(),
  ));

  //! Core
  sl.registerLazySingleton<Networkinfo>(
          () => NetworkInfoImpl(connectionChecker: sl())
  );

  //! External
  sl.registerLazySingleton(() => FirebaseAuth.instance); // Firebase Auth instance
  sl.registerLazySingleton(() => FirebaseFirestore.instance); // Firestore instance
  sl.registerLazySingleton(() => InternetConnectionChecker()); // Internet connection checker
}

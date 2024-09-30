import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/networkInfo.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/auth/domain/auth_repository.dart';
import 'features/auth/domain/usecase/login_use_case.dart';
import 'features/auth/domain/usecase/sign_up_use_case.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    signUpUseCase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  // Core
  sl.registerLazySingleton<Networkinfo>(
        () => NetworkInfoImpl(connectionChecker: sl()), // Fetch and pass InternetConnectionChecker instance
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker()); // Ensure this is registered before use
}

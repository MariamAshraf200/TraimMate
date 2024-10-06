import 'package:check_weather/features/auth/domain/usecase/logout_use_case.dart';
import 'package:check_weather/features/getWeather/data/remote_data.dart';
import 'package:check_weather/features/getWeather/data/repo_impl.dart';
import 'package:check_weather/features/getWeather/domain/repo.dart';
import 'package:check_weather/features/getWeather/domain/usecase.dart';
import 'package:check_weather/features/getWeather/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../features/auth/data/auth_repository_impl.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/auth/domain/usecase/login_use_case.dart';
import '../features/auth/domain/usecase/sign_up_use_case.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import 'network/networkInfo.dart';
final sl = GetIt.instance;

Future<void> init() async {
  //Feature => Autontcation
  // Bloc
  sl.registerFactory(() => AuthBloc(
    logoutUseCase: sl(),
    loginUseCase: sl(),
    signUpUseCase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(()=> LogoutUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  //Feature => get weather with api
  //Bloc
  sl.registerFactory(()=>WeatherBloc(
      getWeatherUseCase : sl()
  ));

  //use case
  sl.registerLazySingleton(()=>GetWeatherUseCase(sl()));


  // Repo
  sl.registerLazySingleton<WeatherRepository>(
      ()=> WeatherRepositoryImpl(sl())
  );
  // remote data source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      ()=> WeatherRemoteDataSource()
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

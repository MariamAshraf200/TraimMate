import 'package:check_weather/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:check_weather/features/auth/presentation/ui/login.dart';
import 'package:check_weather/features/auth/presentation/ui/signup.dart';
import 'package:check_weather/features/getWeather/data/remote_data.dart';
import 'package:check_weather/features/getWeather/data/repo_impl.dart';
import 'package:check_weather/features/getWeather/domain/usecase.dart';
import 'package:check_weather/features/getWeather/presentation/bloc/bloc.dart';
import 'package:check_weather/features/getWeather/presentation/ui/weather.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'depency_injection.dart' as di;
import 'depency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthBloc>(), // Inject AuthBloc
        ),
        BlocProvider(
          create: (_) => WeatherBloc(
            GetWeatherUseCase(WeatherRepositoryImpl(
              remoteDataSource: WeatherRemoteDataSource(),
            )),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/location': (context) => const WeatherScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

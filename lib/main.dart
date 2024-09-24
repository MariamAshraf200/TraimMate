import 'package:check_weather/core/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection_container.dart';
import 'features/user/presentation/bloc/auth_bloc.dart';
import 'features/user/presentation/page/splach_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize the service locator (dependency injection)
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide your AuthBloc here
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
        // Add other Blocs if needed
      ],

      child: const MaterialApp(
        home: SplachScreen(), // Corrected
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

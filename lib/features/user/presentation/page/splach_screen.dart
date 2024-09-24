import 'package:check_weather/features/user/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/2.jpg', scale: 500),
      backgroundImage: const AssetImage('assets/images/4.jpg'),
      durationInSeconds: 4,
      showLoader: false,
      navigator: LoginScreen(), // Navigate to login screen after splash
    );
  }
}


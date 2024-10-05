
import 'package:flutter/cupertino.dart';
import '../features/auth/presentation/ui/login.dart';
import '../features/auth/presentation/ui/signup.dart';
import '../features/getWeather/presentation/ui/weather.dart';

class routes{
  Map<String,WidgetBuilder> getRoute(){
    return{
      '/login': (context) => LoginPage(),
      '/signup': (context) => SignUpPage(),
      '/location': (context) => const WeatherScreen(),
  };
}
}
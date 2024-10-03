// weather_bloc.dart

import 'package:check_weather/features/getWeather/presentation/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase.dart';
import 'event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc( { required  this.getWeatherUseCase}) : super(WeatherInitial()) {

    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getWeatherUseCase.call(event.latitude, event.longitude);
        emit(WeatherLoaded(weather)); // Emit loaded state with full weather data
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}

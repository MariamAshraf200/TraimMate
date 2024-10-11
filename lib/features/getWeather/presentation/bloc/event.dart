
abstract class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final double latitude;
  final double longitude;

  GetWeatherEvent({required this.latitude, required this.longitude});
}

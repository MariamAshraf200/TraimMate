class Weather {
  final String locationName;
  final double currentTemperatureC;
  final String currentCondition;
  final String currentIconUrl;
  final List<DailyWeather> forecast;

  Weather({
    required this.locationName,
    required this.currentTemperatureC,
    required this.currentCondition,
    required this.currentIconUrl,
    required this.forecast,
  });
}

class DailyWeather {
  final String date;
  final double maxTempC;
  final double minTempC;
  final String condition;
  final String iconUrl;

  DailyWeather({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.iconUrl,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';
import '../../../../core/helper/gelocator_helpr.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late WeatherBloc _weatherBloc;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _fetchLocationAndWeather();
  }

  Future<void> _fetchLocationAndWeather() async {
    try {
      Position position = await GelocatorHelpr().determinePosition();
      _weatherBloc.add(GetWeatherEvent(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            final selectedDay = weather.forecast[_selectedIndex];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Days of the Week',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildForecastSection(weather),
                    const SizedBox(height: 10),
                    _buildSelectedDaySection(selectedDay),
                    Center(child: _buildRefreshButton()),
                  ],
                ),
              ),
            );
          } else if (state is WeatherError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildForecastSection(weather) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.forecast.length,
        itemBuilder: (context, index) {
          final day = weather.forecast[index];
          final dayName = DateFormat('EEEE').format(DateTime.parse(day.date));

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Card(
              color: _selectedIndex == index
                  ? Colors.blueAccent
                  : const Color(0xff2b5c6b),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(dayName, style: const TextStyle(color: Colors.white)),
                    Image.network(day.iconUrl, height: 50),
                    const SizedBox(height: 5),
                    Text('${day.maxTempC}° / ${day.minTempC}°',
                        style: const TextStyle(color: Colors.white)),
                    Text(day.condition,
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedDaySection(selectedDay) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color(0xff2b5c6b),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selected Day: ${DateFormat('EEEE').format(DateTime.parse(selectedDay.date))}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Image.network(selectedDay.iconUrl, height: 80),
              const SizedBox(height: 10),
              Text(
                'Max Temp: ${selectedDay.maxTempC}°C',
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 5),
              Text(
                'Min Temp: ${selectedDay.minTempC}°C',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 5),
              Text(
                'Condition: ${selectedDay.condition}',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return TextButton(
      onPressed: _fetchLocationAndWeather,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: const Color(0xff253340),
      ),
      child: const Text('Refresh Weather', style: TextStyle(fontSize: 18)),
    );
  }
}

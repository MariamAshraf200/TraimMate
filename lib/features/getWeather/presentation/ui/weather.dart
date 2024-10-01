import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart'; // for day names
import '../../../../core/helper/gelocator_helpr.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc _weatherBloc;
  int _selectedIndex = 0; // Track the selected day index

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context); // Provided by BlocProvider
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

  // Build Current Weather Section
  Widget _buildCurrentWeatherSection(weather) {
    return Card(
      color: const Color(0xff2b5c6b),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Image.network(
                weather.currentIconUrl,
                height: 80,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: ${weather.locationName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Current Temp: ${weather.currentTemperatureC}°C',
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 5),
            Text(
              'Condition: ${weather.currentCondition}',
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // Build Forecast Section with day name and icon
  Widget _buildForecastSection(weather) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2, // 20% of screen height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather.forecast.length,
        itemBuilder: (context, index) {
          final day = weather.forecast[index];
          final dayName = DateFormat('EEEE').format(DateTime.parse(day.date));

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index; // Update selected day index
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                    Image.network(
                      day.iconUrl,
                      height: 50,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${day.maxTempC}° / ${day.minTempC}°',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      day.condition,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Refresh Button
  Widget _buildRefreshButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: _fetchLocationAndWeather,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          backgroundColor: const Color(0xff253340),
        ),
        child: const Text(
          'Refresh Weather',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
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

            return Container(
              color: const Color(0xff1c4257),
              child: SingleChildScrollView( // Make the body scrollable
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildCurrentWeatherSection(weather),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '7-Day Forecast',
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
                      Padding(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Selected Day: ${DateFormat('EEEE').format(DateTime.parse(selectedDay.date))}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Image.network(
                                  selectedDay.iconUrl,
                                  height: 80,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Max Temp: ${selectedDay.maxTempC}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Min Temp: ${selectedDay.minTempC}°C',
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Condition: ${selectedDay.condition}',
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _buildRefreshButton(), // Display refresh button at the bottom
                    ],
                  ),
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
            child: Text(
              'Press the button to fetch weather.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:check_weather/core/helper/gelocator_helpr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<Color> _colors = [
    Color(0xff1c4257),
    Color(0xff253340),
  ];

  GelocatorHelpr gelocatorHelpr = GelocatorHelpr();
  bool isLoading = false;
  String? location; // Store the location here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: LinearGradient(colors: _colors)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Always display the map image, regardless of the location state
              Image.asset(
                'assets/images/2.png', // Path to the image in assets
                width: 600,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),

              // Show progress or location
              isLoading
                  ? CircularProgressIndicator() // Show progress indicator when loading
                  : location != null // If the location is fetched, show it
                  ? Text(
                location!,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              )
                  : Text('Press button to get location',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),

              // Button to get location
              ElevatedButton(
                onPressed: _getLocation,
                child: Text('Get Location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _colors[0], // Button background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Logic separated into a method for clean code
  Future<void> _getLocation() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Fetch the location
    String fetchedLocation = await gelocatorHelpr.determinePosition();

    setState(() {
      location = fetchedLocation; // Update location
      isLoading = false; // Stop loading indicator
    });
  }
}

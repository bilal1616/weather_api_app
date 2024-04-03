import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api_app/provider/weather_provider.dart';
import 'package:weather_api_app/widgets/background_image.dart';
import 'screens/weather_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Stack(
            children: [
              BackgroundImage(),
              WeatherScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_api_example/geo_search_api.dart';
import 'package:weather_api_example/revgeocode_api.dart';
import 'package:geolocator/geolocator.dart';
import 'geocode_api.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GeoSearchApi(),
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

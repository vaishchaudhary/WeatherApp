import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_api_example/geo_locator_file.dart';
import 'package:weather_api_example/revgeocode_api.dart';

import 'geo_search_api.dart';
import 'geocode_api.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.lat, this.lng}) : super(key: key);
  final String title;
  final double lat, lng;

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(this.title, this.lat, this.lng);
}

class _MyHomePageState extends State<MyHomePage> {
  String text = 'GeoSearch';
  final String title;
  final double lat, lng;

  _MyHomePageState(this.title, this.lat, this.lng);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.wb_sunny)),
              Tab(icon: Icon(Icons.wb_cloudy)),
              Tab(icon: Icon(Icons.ac_unit)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // GeoSearchApi(),
            RevGeocodeApi(
              lat: lat,
              lng: lng,
              place: title,
            ),
            GeoCodeApi(
              lat: lat,
              lng: lng,
              place: title,
            ),
            GeoCodingApi(
              lng: lng,
              lat: lat,
              place: title,
            ),
          ],
        ),
      ),
    );
  }
}

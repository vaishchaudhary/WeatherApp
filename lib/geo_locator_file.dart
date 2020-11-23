import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:geocoding/geocoding.dart';

class GeoCodingApi extends StatefulWidget {
  final String place;
  final lat, lng;

  GeoCodingApi({this.place, Key key, this.lat, this.lng}) : super(key: key);

  @override
  _GeoCodingApiState createState() =>
      _GeoCodingApiState(this.place, this.lat, this.lng);
}

class _GeoCodingApiState extends State<GeoCodingApi> {
  var response;

  final String place;
  final lat, lng;
  List<Location> locations;
  List<Placemark> placemarks;

  _GeoCodingApiState(this.place, this.lat, this.lng);

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final query = "$place";
    var response = await locationFromAddress(query);
    print(response[0].longitude.toString() + 'ggggggggggggggggg');
    var response1 = await placemarkFromCoordinates(lat, lng);
    print(response1[0].street);
    setState(() {
      locations = response;
      placemarks = response1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locations != null && placemarks != null)
      return Column(
        children: [
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            alignment: Alignment.centerLeft,
            child: Text('GeoCoding Using Location......',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: locations.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        if (locations[i].latitude != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('latitude'),
                              ),
                              Expanded(
                                  child:
                                      Text(locations[i].latitude.toString())),
                            ],
                          ),
                        if (locations[i].longitude != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('longitude'),
                              ),
                              Expanded(
                                  child:
                                      Text(locations[i].longitude.toString())),
                            ],
                          ),
                        if (locations[i].timestamp != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('timestamp'),
                              ),
                              Expanded(
                                  child:
                                      Text(locations[i].timestamp.toString())),
                            ],
                          ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        )
                      ],
                    );
                  })),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            alignment: Alignment.centerLeft,
            child: Text('GeoCoding Using Lat Long......',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: placemarks.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        if (placemarks[i].administrativeArea != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('adminArea'),
                              ),
                              Expanded(
                                  child:
                                      Text(placemarks[i].administrativeArea)),
                            ],
                          ),
                        if (placemarks[i].isoCountryCode != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('countryCode'),
                              ),
                              Expanded(
                                  child: Text(placemarks[i].isoCountryCode)),
                            ],
                          ),
                        if (placemarks[i].country != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('countryName'),
                              ),
                              Expanded(child: Text(placemarks[i].country)),
                            ],
                          ),
                        if (placemarks[i].street != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('street'),
                              ),
                              Expanded(child: Text(placemarks[i].street)),
                            ],
                          ),
                        if (placemarks[i].thoroughfare != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('thoroughfare'),
                              ),
                              Expanded(child: Text(placemarks[i].thoroughfare)),
                            ],
                          ),
                        if (placemarks[i].postalCode != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('postalCode'),
                              ),
                              Expanded(child: Text(placemarks[i].postalCode)),
                            ],
                          ),
                        if (placemarks[i].locality != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('locality'),
                              ),
                              Expanded(child: Text(placemarks[i].locality)),
                            ],
                          ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        )
                      ],
                    );
                  }))
        ],
      );

    return Container(
      color: Colors.white,
      child: Center(
        child: Loading(
            indicator: BallPulseIndicator(),
            size: 100.0,
            color: Colors.lightBlueAccent),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:weather_api_example/geocode_class.dart';
import 'package:weather_api_example/geosearch_class.dart';
import 'package:geocoder/geocoder.dart';

class GeoCodeApi extends StatefulWidget {
  final String place;
  final lat, lng;

  GeoCodeApi({this.place, Key key, this.lat, this.lng}) : super(key: key);

  @override
  _GeoCodeApiState createState() =>
      _GeoCodeApiState(this.place, this.lat, this.lng);
}

class _GeoCodeApiState extends State<GeoCodeApi> {
  var response;
  GeocodeClass geocodeClass;
  final String place;
  final lat, lng;
  List<Address> addresses, addresses1;

  _GeoCodeApiState(this.place, this.lat, this.lng);

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    final query = "$place";
    var response = await Geocoder.local.findAddressesFromQuery(query);
    final coordinates = new Coordinates(lat, lng);
    var response1 =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      addresses = response;
      addresses1 = response1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (addresses != null && addresses1 != null)
      return Column(
        children: [
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            alignment: Alignment.centerLeft,
            child: Text('GeoCoder Using Location......',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: addresses.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        if (addresses[i].adminArea != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('adminArea'),
                              ),
                              Expanded(child: Text(addresses[i].adminArea)),
                            ],
                          ),
                        if (addresses[i].coordinates.latitude.toString() !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('latitude'),
                              ),
                              Expanded(
                                  child: Text(addresses[i]
                                      .coordinates
                                      .latitude
                                      .toString())),
                            ],
                          ),
                        if (addresses[i].coordinates.longitude.toString() !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('longitude'),
                              ),
                              Expanded(
                                  child: Text(addresses[i]
                                      .coordinates
                                      .longitude
                                      .toString())),
                            ],
                          ),
                        if (addresses[i].countryCode != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('countryCode'),
                              ),
                              Expanded(child: Text(addresses[i].countryCode)),
                            ],
                          ),
                        if (addresses[i].countryName != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('countryName'),
                              ),
                              Expanded(child: Text(addresses[i].countryName)),
                            ],
                          ),
                        if (addresses[i].featureName != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('featureName'),
                              ),
                              Expanded(child: Text(addresses[i].featureName)),
                            ],
                          ),
                        if (addresses[i].addressLine != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('addressLine'),
                              ),
                              Expanded(child: Text(addresses[i].addressLine)),
                            ],
                          ),
                        if (addresses[i].thoroughfare != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('thoroughfare'),
                              ),
                              Expanded(child: Text(addresses[i].thoroughfare)),
                            ],
                          ),
                        if (addresses[i].postalCode != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('postalCode'),
                              ),
                              Expanded(child: Text(addresses[i].postalCode)),
                            ],
                          ),
                        if (addresses[i].locality != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('locality'),
                              ),
                              Expanded(child: Text(addresses[i].locality)),
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
            child: Text('GeoCoder Using Lat Long......',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: addresses1.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        if (addresses1[i].adminArea != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('adminArea'),
                              ),
                              Expanded(child: Text(addresses1[i].adminArea)),
                            ],
                          ),
                        if (addresses1[i].coordinates.latitude != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('latitude'),
                              ),
                              Expanded(
                                  child: Text(addresses1[i]
                                      .coordinates
                                      .latitude
                                      .toString())),
                            ],
                          ),
                        if (addresses1[i].coordinates.longitude != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('longitude'),
                              ),
                              Expanded(
                                  child: Text(addresses1[i]
                                      .coordinates
                                      .longitude
                                      .toString())),
                            ],
                          ),
                        if (addresses1[i].countryCode != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('countryCode'),
                              ),
                              Expanded(child: Text(addresses1[i].countryCode)),
                            ],
                          ),
                        if (addresses1[i].countryName != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('countryName'),
                              ),
                              Expanded(child: Text(addresses1[i].countryName)),
                            ],
                          ),
                        if (addresses1[i].featureName != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('featureName'),
                              ),
                              Expanded(child: Text(addresses1[i].featureName)),
                            ],
                          ),
                        if (addresses1[i].addressLine != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('addressLine'),
                              ),
                              Expanded(child: Text(addresses1[i].addressLine)),
                            ],
                          ),
                        if (addresses1[i].thoroughfare != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('thoroughfare'),
                              ),
                              Expanded(child: Text(addresses1[i].thoroughfare)),
                            ],
                          ),
                        if (addresses1[i].postalCode != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('postalCode'),
                              ),
                              Expanded(child: Text(addresses1[i].postalCode)),
                            ],
                          ),
                        if (addresses1[i].locality != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                child: Text('locality'),
                              ),
                              Expanded(child: Text(addresses1[i].locality)),
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

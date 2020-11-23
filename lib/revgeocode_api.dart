import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:weather_api_example/geocode_api.dart';
import 'package:weather_api_example/rev_geocode_class.dart';

import 'geocode_class.dart';

class RevGeocodeApi extends StatefulWidget {
  final double lat, lng;
  final String place;

  RevGeocodeApi({this.lat, this.lng, this.place, Key key}) : super(key: key);

  @override
  _RevGeocodeApiState createState() =>
      _RevGeocodeApiState(this.lat, this.lng, this.place);
}

class _RevGeocodeApiState extends State<RevGeocodeApi> {
  RevGeocodeClass revGeocodeClass;
  GeocodeClass geocodeClass;
  final String place;
  final double lat, lng;

  _RevGeocodeApiState(this.lat, this.lng, this.place);

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    fetchData1();
  }

  Future<void> fetchData() async {
    print(lat.toString() + lng.toString() + 'gggggggggggggggggggg');
    final response = await http.get(
        'https://geoproxy.dev.iamplus.services/revgeocode?location=${lat.toString()},${lng.toString()}');

    if (response.statusCode == 200) {
      revGeocodeClass = RevGeocodeClass.fromJson(jsonDecode(response.body));

      setState(() {
        revGeocodeClass = RevGeocodeClass.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> fetchData1() async {
    print(place);
    final response = await http
        .get('https://geoproxy.dev.iamplus.services/geocode?address=$place');

    if (response.statusCode == 200) {
      geocodeClass = GeocodeClass.fromJson(jsonDecode(response.body));

      setState(() {
        geocodeClass = GeocodeClass.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (revGeocodeClass != null && geocodeClass != null)
      return Column(
        children: [
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            alignment: Alignment.centerLeft,
            child: Text(' Using RevGeoCode Api......',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: revGeocodeClass.results.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('Formatted Address'),
                            ),
                            Expanded(
                                child: Text(revGeocodeClass
                                    .results[i].formattedAddress)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('Latitute'),
                            ),
                            Expanded(
                                child: Text(revGeocodeClass
                                    .results[i].geometry.location.lat
                                    .toString()))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('Longitude'),
                            ),
                            Expanded(
                                child: Text(revGeocodeClass
                                    .results[i].geometry.location.lng
                                    .toString()))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('PlaceId'),
                            ),
                            Expanded(
                                child: Text(revGeocodeClass.results[i].placeId
                                    .toString()))
                          ],
                        ),
                        Container(
                          child: Text(
                            'Northeast ViewPorts:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Text('lat'), Text('long')],
                        ),
                        if (revGeocodeClass.results[i].geometry.viewport !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('' +
                                  revGeocodeClass.results[i].geometry.viewport
                                      .northeast.lat
                                      .toString()),
                              Text('' +
                                  revGeocodeClass.results[i].geometry.viewport
                                      .northeast.lng
                                      .toString()),
                            ],
                          ),
                        Container(
                          child: Text(
                            'Southwest ViewPorts:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Text('lat'), Text('long')],
                        ),
                        if (revGeocodeClass.results[i].geometry.viewport !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(revGeocodeClass
                                  .results[i].geometry.viewport.southwest.lat
                                  .toString()),
                              Text(revGeocodeClass
                                  .results[i].geometry.viewport.southwest.lng
                                  .toString()),
                            ],
                          ),
                        Container(
                          child: Text(
                            'Address Components:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        for (int j = 0;
                            j <
                                revGeocodeClass
                                    .results[i].addressComponents.length;
                            j++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Text('Component ' + (j + 1).toString() + ':'),
                              Padding(padding: EdgeInsets.only(top: 2)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Short Name'),
                                  Text(revGeocodeClass.results[i]
                                      .addressComponents[j].shortName)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Long Name'),
                                  Text(revGeocodeClass
                                      .results[i].addressComponents[j].longName)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Address Component Types'),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        for (int k = 0;
                                            k <
                                                revGeocodeClass
                                                    .results[i]
                                                    .addressComponents[j]
                                                    .types
                                                    .length;
                                            k++)
                                          Text(revGeocodeClass.results[i]
                                              .addressComponents[j].types[k])
                                      ],
                                    ),
                                  )
                                  // Expanded(
                                  //
                                  //   child:Text(revGeocodeClass.results[i].addressComponents[j].types.toString()),
                                  //   flex: 2,
                                  //
                                  // )
                                ],
                              ),
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
            child: Text(' Using GeoCode Api......',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue)),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: geocodeClass.results.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('Formatted Address'),
                            ),
                            Expanded(
                                child: Text(
                                    geocodeClass.results[i].formattedAddress)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('Latitute'),
                            ),
                            Expanded(
                                child: Text(geocodeClass
                                    .results[i].geometry.location.lat
                                    .toString()))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('Longitude'),
                            ),
                            Expanded(
                                child: Text(geocodeClass
                                    .results[i].geometry.location.lng
                                    .toString()))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text('PlaceId'),
                            ),
                            Expanded(
                                child: Text(
                                    geocodeClass.results[i].placeId.toString()))
                          ],
                        ),
                        Container(
                          child: Text(
                            'Northeast ViewPorts:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Text('lat'), Text('long')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(geocodeClass
                                .results[i].geometry.viewport.northeast.lat
                                .toString()),
                            Text(geocodeClass
                                .results[i].geometry.viewport.northeast.lng
                                .toString()),
                          ],
                        ),
                        Container(
                          child: Text(
                            'Southwest ViewPorts:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Text('lat'), Text('long')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(geocodeClass
                                .results[i].geometry.viewport.southwest.lat
                                .toString()),
                            Text(geocodeClass
                                .results[i].geometry.viewport.southwest.lng
                                .toString()),
                          ],
                        ),
                        Container(
                          child: Text(
                            'Address Components:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        for (int j = 0;
                            j <
                                geocodeClass
                                    .results[i].addressComponents.length;
                            j++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Text('Component ' + (j + 1).toString() + ':'),
                              Padding(padding: EdgeInsets.only(top: 2)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Short Name'),
                                  Text(geocodeClass.results[i]
                                      .addressComponents[j].shortName)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Long Name'),
                                  Text(geocodeClass
                                      .results[i].addressComponents[j].longName)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Address Component Types'),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        for (int k = 0;
                                            k <
                                                geocodeClass
                                                    .results[i]
                                                    .addressComponents[j]
                                                    .types
                                                    .length;
                                            k++)
                                          Text(geocodeClass.results[i]
                                              .addressComponents[j].types[k])
                                      ],
                                    ),
                                  )
                                ],
                              ),
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

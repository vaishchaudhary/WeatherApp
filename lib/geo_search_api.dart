import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:search_page/search_page.dart';
import 'package:weather_api_example/geosearch_class.dart';
import 'package:weather_api_example/home_page.dart';

class GeoSearchApi extends StatefulWidget {
  GeoSearchApi({Key key}) : super(key: key);

  @override
  _GeoSearchApiState createState() => _GeoSearchApiState();
}

class _GeoSearchApiState extends State<GeoSearchApi> {
  var response;
  GeoSearchClass geoSearchClass;
  List<Predictions> predictions;
  String place = 'agra';

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    fetchData();
  }

  TextEditingController _textEditingController;

  Future<void> fetchData() async {
    final response = await http.get(
        'https://geoproxy.dev.iamplus.services/search?input=' +
            place +
            '&location=0,0');

    if (response.statusCode == 200) {
      geoSearchClass = GeoSearchClass.fromJson(jsonDecode(response.body));
      predictions = geoSearchClass.predictions;
      setState(() {
        geoSearchClass = GeoSearchClass.fromJson(jsonDecode(response.body));
        predictions = geoSearchClass.predictions;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Column(children: [
        if (predictions != null)
          Container(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: 'Enter a search term'),
              controller: _textEditingController,
              onChanged: (text) {
                place = text;
                print("First text field: $text");
              },
              onSubmitted: (text) {
                setState(() {
                  place = text;
                });
              },
            ),
          ),
        if (predictions != null)
          Expanded(
            child: ListView.builder(
                itemCount: geoSearchClass.predictions != null
                    ? geoSearchClass.predictions.length
                    : 0,
                itemBuilder: (context, index) {
                  final Predictions result = geoSearchClass.predictions != null
                      ? predictions[index]
                      : null;
                  if (result != null)
                    return ListTile(
                        title: Text(result.title),
                        subtitle: Text(result.description),
                        trailing: Text('${result.distanceMeters.toString()}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                      title: result.title,
                                      lat: result.location.lat,
                                      lng: result.location.lng,
                                    )),
                          );
                        });
                }),
          ),
        if (predictions == null)
          Container(
            color: Colors.white,
            child: Center(
              child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 100.0,
                  color: Colors.lightBlueAccent),
            ),
          )
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search people',
        onPressed: () => {fetchData()},
        child: Icon(Icons.search),
      ),
    );
  }
}

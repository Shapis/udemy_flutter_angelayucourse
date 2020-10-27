import 'dart:math';
import 'package:clima/services/location.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location location = Location();
    Point myPoint = await location.getCurrentLocation();
    print(myPoint.x);
    print(myPoint.y);
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=$kAPIKey');
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}

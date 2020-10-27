import 'dart:math';

import 'package:geolocator/geolocator.dart';

class Location {
  Future<Point> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      return Point(position.latitude, position.longitude);
    } catch (err) {}
  }
}

import 'package:flutter/material.dart';
import 'package:location/models/locations_data.dart';

import '../models/location.dart';


class LocationService {
  var _locations;

  LocationService(){
    _locations = LocationsData.buildList();
  }

  List<Location> getLocations() {
    return _locations;
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

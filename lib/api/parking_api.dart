import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:parkingfreemium/model/parking.dart';

class ParkingApi {
  static Future<List<Parking>> getParkingList() async {
    List<Parking> myList = List<Parking>();

    Parking parking1 = new Parking();
    parking1.id = 1;
    parking1.name = "tester1";
    parking1.adress = "AV. Evergreen 123";
    myList.add(parking1);

    return Future.delayed(Duration(seconds: 2), () => myList);
  }
}

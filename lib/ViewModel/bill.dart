import 'package:flutter/foundation.dart';

class Bill {
  late String clientName;
  late String phoneNumber;
  late String location;
  late dynamic service;
  late String price;
  //late DateTime dateTime;

  //creating singleton
  Bill._privateConstructore();
  static final Bill _instance = Bill._privateConstructore();
  factory Bill() {
    return _instance;
  }

  String get getClientName => clientName;
  String get getPhoneNumber => phoneNumber;
  String get getLocation => location;
  dynamic get getService => service;
  String get getPrice => price;
  //DateTime get getDateTime => dateTime;

  set setClientName(String name) => clientName = name;
  set setPhoneNumber(String phone) => phoneNumber = phone;
  set setLocation(String loc) => location = loc;
  set setService(dynamic srv) => service = srv;
  set setPrice(String prc) => price = prc;
  //set setDateTime(DateTime dt) => dateTime = dt;

  void detach() {
    clientName = '';
    phoneNumber = '';
    location = '';
    service = null;
    price = '';
  }
}

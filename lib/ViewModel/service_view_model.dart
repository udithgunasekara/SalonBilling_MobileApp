import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/View/services_catalogs/Haricut.dart';
import 'package:salon_mobile/View/services_catalogs/dressing.dart';
import 'package:salon_mobile/View/services_catalogs/threading.dart';

class ServiceViewModel {
//creating private constructor
  ServiceViewModel._privateConstructore();

  //static instance
  static final ServiceViewModel _instance =
      ServiceViewModel._privateConstructore();

  //factory constructore return same instance
  factory ServiceViewModel() {
    return _instance;
  }

  final ServiceRepository _serviceRepository = ServiceRepository();

  List<Map<String, dynamic>> _service = [];
  Map<String, dynamic> _servicesHash = {};

  late Box salonBox;
  late Map<String, dynamic> salonBoxData;

  String? defualPricee = "____";

  //ValueNotifier for change state
  final ValueNotifier<String> defualPrice = ValueNotifier<String>("_-___");

  List<Map<String, dynamic>> get services => _service;
  Map<String, dynamic> get servicesHash => _servicesHash;

  Future<void> fetchAndSaveServices() async {
    try {
      _service = await _serviceRepository.fetchServices();

      // _servicesHash = {for (var service in _service) service['id']: service};
      // print('All services saved in servicesHash: $_servicesHash');

      //get the salonBox and print them into here.
      salonBox = await Hive.openBox('salonBox');
      salonBoxData = Map<String, dynamic>.from(salonBox.toMap());
    } catch (e) {
      print('Service fetching Error: $e');
    }
  }

  List<Map<String, dynamic>> searchServices(String query) {
    return _service
        .where((service) =>
            service['name'].toLowerCase().contains(query.toLowerCase()) ||
            service['id'].toString().contains(query))
        .toList();
  }

  Widget showSelectedService(String text) {
    switch (text) {
      case 'Threading':
        print("Test selection pass: $text");
        passFinalValue(
            text); //Here i can improve the code add it upper switch case
        return Threading();

      case 'Haircut':
        passFinalValue(text);
        return Haricut();

      case 'Dressing':
        passFinalValue(text);
        return Dressing();

      default:
        return Container(); // return empty container for ref null
    }
  }

//pass def value
  void passFinalValue(String text, {List<String>? serviceList}) async {
//use servicehashr

    print("What Text: $text");
    print("Check1 Service: $services");
    print("Check1 HashService: $servicesHash");
    print("what in Hive: $salonBoxData");

    // print('SalonBox Data:');
    // salonBoxData.forEach((key, value) {
    //   print('Key: $key, Value: $value');
    // });

    //if (serviceList == null) {
    //return defult price
    salonBoxData.forEach((key, service) {
      if (service['name'] == text) {
        var price = service['prices'];
        if (price is Map) {
          print("answered");
          print("YES with is MAP: $text");
          print("serviceList in model: $serviceList");

          // access the key and value in map

          //for (var i = 0; i >= serviceList!.length; i++) {
          var priceCount = 0;
          price.forEach((key, value) {
            print('key is $key and its value is $value ');
            // Update priceCount based on serviceList if provided
            if (serviceList == null || serviceList.contains(key)) {
              priceCount += int.parse(value);
              print("Current Price: $priceCount");
            }
          });
          // Update the ValueNotifier with the new price
          defualPrice.value = priceCount.toString();
          print("Current Price in Downq: ${priceCount.toString()}");
        } else {
          defualPrice.value = service['prices'];
        }
      }
    });

    // defualPrice = "select Option";
  }
}

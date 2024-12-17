import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/View/services_catalogs/Haricut.dart';
import 'package:salon_mobile/View/services_catalogs/dressing.dart';
import 'package:salon_mobile/View/services_catalogs/threading.dart';

class ServiceViewModel {
  final ServiceRepository _serviceRepository = ServiceRepository();

  List<Map<String, dynamic>> _service = [];
  Map<String, dynamic> _servicesHash = {};

  String? defualPrice = "____";

  List<Map<String, dynamic>> get services => _service;
  Map<String, dynamic> get servicesHash => _servicesHash;

  Future<void> fetchAndSaveServices() async {
    try {
      _service = await _serviceRepository.fetchServices();
      _servicesHash = {for (var service in _service) service['id']: service};
      // print('All services saved in servicesHash: $_servicesHash');
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
  void passFinalValue(String text, {List<String>? serviceList}) {
//use servicehashr
    print("What Text: $text");
    print("Check1 Service: $services");
    print("Check1 HashService: $servicesHash");

    //if (serviceList == null) {
    //return defult price
    for (var service in services) {
      if (service['name'] == text) {
        var price = service['prices'];
        if (price is Map) {
          print("answered");
          print("YES with is MAP: $text");
          print("serviceList in model: $serviceList");

          // access the key and value in map
          price.forEach((key, value) {
            print('key is $key and its value is $value ');
          });

          defualPrice = '____';
        } else {
          defualPrice = service['prices'];
        }
      }
    }
    // defualPrice = "select Option";
  }
}

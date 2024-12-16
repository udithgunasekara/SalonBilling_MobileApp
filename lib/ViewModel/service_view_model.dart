import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/View/services_catalogs/dressing.dart';
import 'package:salon_mobile/View/services_catalogs/threading.dart';

class ServiceViewModel {
  final ServiceRepository _serviceRepository = ServiceRepository();

  List<Map<String, dynamic>> _service = [];
  Map<String, dynamic> _servicesHash = {};

  String? defualPrice;

  List<Map<String, dynamic>> get services => _service;
  Map<String, dynamic> get servicesHash => _servicesHash;

  Future<void> fetchAndSaveServices() async {
    try {
      _service = await _serviceRepository.fetchServices();
      // _servicesHash = {for (var service in _service) service['id']: service};
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
        return Dressing();

      default:
        return Container(); // return empty container for ref null
    }
  }

//pass def value
  void passFinalValue(String text) {
//use servicehashr

    print("Hash: $services");
    print("HashValues: ${servicesHash.values}");
    for (var servicee in services) {
      print("serviceName: $servicee");
      if (servicee['name'] == text) {
        defualPrice = servicee['prices'];
        print("Returing defult: $defualPrice");
      }
      print("State 1");
    }
    // return 0 if no matching service is found
    print("State 2");
  }
}

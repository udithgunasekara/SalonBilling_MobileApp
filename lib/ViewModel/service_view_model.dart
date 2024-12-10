import 'dart:io';
import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/service.dart';

class ServiceViewModel extends ChangeNotifier {
  final ServiceRepository _serviceRepository = ServiceRepository();

  List<Map<String, dynamic>> _service = [];
  Map<String, dynamic> _servicesHash = {};

  // List<Map<String,dynamic>> get services => _service;
  // Map<String, dynamic>> get servicesHash => _servicesHash;

  List<Map<String, dynamic>> get services => _service;
  Map<String, dynamic> get servicesHash => _servicesHash;

  Future<void> fetchAndSaveServices() async {
    try {
      _service = await _serviceRepository.fetchServices();
      _servicesHash = {for (var service in _service) service['id']: service};
      notifyListeners();
    } catch (e) {
      print('Serive fetching Error: $e');
    }
  }
}

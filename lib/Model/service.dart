import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';

class Service {
  final String providerName;
  final String serviceType;
  final String contactNumber;
  final int price;

  Service({
    required this.providerName,
    required this.serviceType,
    required this.contactNumber,
    required this.price,
  });
}

//Fetching the services list

class ServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Box salonBox;

  ServiceRepository() {
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    salonBox = await Hive.openBox('salonBox');
  }

  Future<List<Map<String, dynamic>>> fetchServices() async {
    try {
      final snapshot = await _firestore.collection('Services').get();

      final services = snapshot.docs
          // ignore: unnecessary_cast
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      //save date in Hive Box
      await _saveServiceToHive(services);

      // Print services to console
      services.forEach((service) {
        print('Service: $service');
      });

      return services;
    } on SocketException {
      print('Internet is not working:');
      throw Exception('Internet is not working:');
    } catch (e) {
      print('Error fetching Services list: $e');
      throw Exception('Error fetching Services list: $e');
    }
  }

  Future<void> _saveServiceToHive(List<Map<String, dynamic>> service) async {
    try {
      service.asMap().forEach((index, service) async {
        await salonBox.put('service_$index', service);
      });
      print("Services saved Hive is successfull.");
    } catch (e) {
      print("Error saving services to salonBox Hive: $e");
    }
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:salon_mobile/ViewModel/bill.dart';

class Service {
  final String providerName;
  final String serviceType;
  final String contactNumber;
  final int price;
  final String time;

  Service({
    required this.providerName,
    required this.serviceType,
    required this.contactNumber,
    required this.price,
    required this.time,
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

  Future<void> saveServiceToFirebase(Bill bill) async {
    try {
      //Reference to the Bill collection
      CollectionReference bills = _firestore.collection("Bills");

      await bills.add({
        'clientName': bill.getClientName,
        'phoneNumber': bill.getPhoneNumber,
        'location': bill.getLocation,
        'service': bill.getService,
        'price': bill.getPrice,
        'whatsApp': bill.getWhatsAppStatus,

        'timestamp': FieldValue.serverTimestamp(), // Firestore server timestamp
      });
      print("Service saved Successfully");
    } catch (e) {
      print('Error saving service: $e');
    }
  }
}

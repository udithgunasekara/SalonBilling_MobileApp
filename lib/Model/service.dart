import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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

  Future<List<Map<String, dynamic>>> fetchServices() async {
    try {
      final snapshot = await _firestore.collection('Services').get();

      final services = snapshot.docs
          // ignore: unnecessary_cast
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

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
}



// class ServiceRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Map<String, dynamic>>> fetchServices() async {
//     try {
//       final snapshot = await _firestore.collection('Services').get();

//       return snapshot.docs
//           // ignore: unnecessary_cast
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//     } on SocketException {
//       print('Internet is not working:');
//       throw Exception('Internet is not working:');
//     } catch (e) {
//       print('Error fetching Services list: $e');
//       throw Exception('Error fetching Services list: $e');
//     }
//   }
// }


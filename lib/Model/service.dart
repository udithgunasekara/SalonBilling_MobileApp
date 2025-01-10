import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:salon_mobile/ViewModel/bill.dart';

class Service {
  final String providerName;
  final dynamic serviceType; // This can be either String or List<String>
  final String contactNumber;
  final String time;
  final String price;

  Service({
    required this.providerName,
    required this.serviceType,
    required this.contactNumber,
    required this.time,
    required this.price,
  });

  static Service fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Handle serviceType that can be either String or List
    var serviceType = data['service'];
    dynamic formattedServiceType;

    if (serviceType is String) {
      formattedServiceType = serviceType;
    } else if (serviceType is List) {
      formattedServiceType =
          serviceType.join(', '); // Convert array to comma-separated string
    } else {
      formattedServiceType = ''; // Default value if neither string nor list
    }

    return Service(
      providerName: data['clientName']?.toString() ?? '',
      serviceType: formattedServiceType,
      contactNumber: data['phoneNumber']?.toString() ?? '',
      time: data['time']?.toString() ?? '',
      price: data['price']?.toString() ?? '',
    );
  }

  // Helper method to get service type as display string
  String get serviceTypeDisplay {
    if (serviceType is String) {
      return serviceType as String;
    } else if (serviceType is List) {
      return (serviceType as List).join(', ');
    }
    return '';
  }
}

//Fetching the services list

class ServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Box salonBox;

  Future<List<Map<String, dynamic>>> fetchServices() async {
    try {
      final snapshot = await _firestore.collection('Services').get();

      final services = snapshot.docs
          // ignore: unnecessary_cast
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      //save date in Hive Box
      await _saveServiceToHive(services);

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

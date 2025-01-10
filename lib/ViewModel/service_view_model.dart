import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/View/services_catalogs/Haricut.dart';
import 'package:salon_mobile/View/services_catalogs/cleanups.dart';
import 'package:salon_mobile/View/services_catalogs/color_hair.dart';
import 'package:salon_mobile/View/services_catalogs/conditioner_treatment.dart';
import 'package:salon_mobile/View/services_catalogs/dressing.dart';
import 'package:salon_mobile/View/services_catalogs/dye_hair.dart';
import 'package:salon_mobile/View/services_catalogs/facials.dart';
import 'package:salon_mobile/View/services_catalogs/galvanicMassage.dart';
import 'package:salon_mobile/View/services_catalogs/hair_curl.dart';
import 'package:salon_mobile/View/services_catalogs/hair_iron.dart';
import 'package:salon_mobile/View/services_catalogs/menique.dart';
import 'package:salon_mobile/View/services_catalogs/oil_treatment.dart';
import 'package:salon_mobile/View/services_catalogs/pedique.dart';
import 'package:salon_mobile/View/services_catalogs/perming.dart';
import 'package:salon_mobile/View/services_catalogs/pimple_treatment.dart';
import 'package:salon_mobile/View/services_catalogs/rebonding.dart';
import 'package:salon_mobile/View/services_catalogs/relaxing.dart';
import 'package:salon_mobile/View/services_catalogs/threading.dart';
import 'package:salon_mobile/View/services_catalogs/tonic_treatment.dart';
import 'package:salon_mobile/View/services_catalogs/wax.dart';
import 'package:salon_mobile/ViewModel/bill.dart';

class ServiceViewModel {
  ServiceViewModel._privateConstructore();
  static final ServiceViewModel _instance =
      ServiceViewModel._privateConstructore();
  factory ServiceViewModel() {
    return _instance;
  }

  final ServiceRepository _serviceRepository = ServiceRepository();
  final Bill bill = Bill();

  List<Map<String, dynamic>> _service = [];

  late Box salonBox;
  late Map<String, dynamic> salonBoxData;
  String? defualPricee = "____";

  //For billing infor
  late String billPrice;
  late String? serviceName;
  List<String>? serviceNameList;

  final ValueNotifier<String> defualPrice = ValueNotifier<String>("_____");
  List<Map<String, dynamic>> get services => _service;
  Future<void> initializeLocalStorage() async {
    try {
      //fetch services from hive
      salonBox = Hive.box('salonBox');

      salonBoxData = Map<String, dynamic>.from(salonBox.toMap());

      print("Getting2 form Box Data: $salonBoxData");

      _service = salonBoxData.entries.map((entry) {
        if (entry.value is Map) {
          return Map<String, dynamic>.from(entry.value as Map);
        } else if (entry.value is List) {
          // Handle list case if needed
          return {'data': entry.value};
        } else {
          // Handle other cases
          return {'value': entry.value};
        }
      }).toList();

      print("Getting form Box Data: $salonBoxData");
      print("Service Data: $_service");
    } catch (e) {
      print('Service fetching Error: $e');
    }
  }

  Future<void> fetchAndSaveServices() async {
    try {
      //save and fetch services
      _service = await _serviceRepository.fetchServices();
    } catch (e) {
      print('Service fetching Error: $e');
    }
  }

  List<Map<String, dynamic>> searchServices(String query) {
    print("Search Query: $query and Service: $_service");
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
        return const Threading();

      case 'Haircut':
        passFinalValue(text);
        return const HairCut();

      case 'Dressing':
        passFinalValue(text);
        return const Dressing();

      case 'Facials':
        passFinalValue(text);
        return const Facials();

      case 'Clean Ups':
        passFinalValue(text);
        return const CleanUps();

      case 'Wax':
        passFinalValue(text);
        return const Wax();
//donwto update db
      case 'Galvanic Massage':
        passFinalValue(text);
        return const GalvanicMassage();

      case 'Pimple Treatment':
        passFinalValue(text);
        return const PimpleTreatment();

      case 'Menique':
        passFinalValue(text);
        return const Menique();

      case 'Pedique':
        passFinalValue(text);
        return const Pedique();

      case 'Rebonding':
        passFinalValue(text);
        return const Rebonding();

      case 'Perming':
        passFinalValue(text);
        return const Perming();

      //updating here
      case 'Hair Curl Long':
        passFinalValue(text);
        return const HairCurl();

      case 'Oil Treatment':
        passFinalValue(text);
        return const OilTreatment();

      case 'Color Hair':
        passFinalValue(text);
        return const ColorHair();

      case 'Conditioner':
        passFinalValue(text);
        return const ConditionerTreatment();

      case 'Relaxing':
        passFinalValue(text);
        return const Relaxing();

      case 'Dye Hair':
        passFinalValue(text);
        return const DyeHair();

      case 'Tonic Treatment':
        passFinalValue(text);
        return const TonicTreatment();

      case 'Hair Iron':
        passFinalValue(text);
        return const HairIron();

      default:
        return Container(); // return empty container for ref null
    }
  }

//pass def value
  void passFinalValue(String text, {List<String>? serviceList}) async {
//use servicehashr

    print("What Text: $text");
    print("Check1 Service: $services");
    print("what in Hive: $salonBoxData");
    serviceName = text;

    try {
      salonBoxData.forEach((key, service) {
        if (service['name'] == text) {
          var price = service['prices'];
          if (price is Map) {
            print("answered");
            print("YES with is MAP: $text");
            print("serviceList in model: $serviceList");
            serviceNameList = serviceList;

            // access the key and value in map

            //for (var i = 0; i >= serviceList!.length; i++) {
            var priceCount = 0;
            price.forEach((key, value) {
              print('key is $key and its value is $value ');
              // Update priceCount based on serviceList if provided
              if (serviceList!.contains(key)) {
                priceCount += int.parse(value);
                print("Current Price: $priceCount");
              }
            });
            // Update the ValueNotifier with the new price
            billPrice = priceCount.toString();
            defualPrice.value = billPrice;
            print("Current Price in Downq: ${priceCount.toString()}");
          } else {
            billPrice = service["prices"];
            defualPrice.value = billPrice;
          }
        }
      });
    } catch (e) {
      print("Null value returned");
      billPrice = '0';
      defualPrice.value = billPrice;
    }

    // defualPrice = "select Option";
  }

  Future<void> saveBill() async {
    //Variable: billPrice, ServiceName, ServiceList
    try {
      if (billPrice.isEmpty || billPrice == '0') {
        throw Exception('Bill price cannot be empty or zero');
      }

      serviceName;
      serviceNameList;

      //setter value
      bill.setPrice = billPrice;
      bill.setService = serviceNameList ?? serviceName;

      if (serviceNameList == null) {
        print(
            "Here we save single service $serviceName and price : $billPrice");
        await _serviceRepository.saveServiceToFirebase(bill);
        bill.detach();
      } else {
        print(
            "Here we save Multi service $serviceNameList and price : $billPrice");
        await _serviceRepository.saveServiceToFirebase(bill);
        serviceNameList = null;
        bill.detach();
      }
    } catch (e) {
      print('Error saving bill: $e');
      rethrow;
    }
  }

  //handling non fixed prices
// @notify values for defualt values

  void notifychanges(String price, String? selectedService) {
    defualPrice.value = price;
    billPrice = price;
    serviceName = selectedService;
  }
}

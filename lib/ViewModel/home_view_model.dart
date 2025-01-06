import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/View/billingpage/billing_page.dart';

class HomeViewModel {
  final List<Service> _services = [
    Service(
      providerName: 'Nimal',
      serviceType: 'Hair Cut',
      contactNumber: '077 54 865 241',
      time: "3.23PM",
      price: 1800,
    ),
    Service(
      providerName: 'Amasha',
      serviceType: 'Threading',
      contactNumber: '077 54 865 241',
      time: "3.23PM",
      price: 100,
    ),
    Service(
      providerName: 'Amasha',
      serviceType: 'Threading',
      contactNumber: '077 54 865 241',
      price: 100,
      time: "3.23PM",
    ),
    Service(
      providerName: 'Amasha',
      serviceType: 'Threading',
      contactNumber: '077 54 865 241',
      price: 100,
      time: "3.23PM",
    ),
    Service(
      providerName: 'Amasha',
      serviceType: 'Threading',
      contactNumber: '077 54 865 241',
      price: 100,
      time: "3.23PM",
    ),
  ];

  List<Service> get services => _services;

  void navigateToNewBill(BuildContext context) {
    // Implement navigation to the billing page
    print('Navigating to the new bill page');
    //page namge is billing_page.dart
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BillingPage()));
  }
}

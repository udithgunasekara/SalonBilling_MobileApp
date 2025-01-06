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
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const BillingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Start from right
          const end = Offset.zero; // End at center
          const curve = Curves.easeInOutCirc; // Make it smooth

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration:
            const Duration(milliseconds: 400), // Animation duration
      ),
    );
  }
}

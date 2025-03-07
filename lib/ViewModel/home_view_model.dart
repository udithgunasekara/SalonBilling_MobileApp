import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/homeService.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/View/billingpage/billing_page.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepositoryService _repositoryService = HomeRepositoryService();
  List<Service> _services = [];
  bool _isLoading = true;

  Stream<List<Service>> get servicesStream => _repositoryService.getBills();

  List<Service> get services => _services;
  bool get isLoading => _isLoading;

  // HomeViewModel() {
  //   _initializeData();
  // }

  // void _initializeData() {
  //   _repositoryService.getBills().listen((bills) {
  //     _services = bills;
  //     _isLoading = false;
  //     notifyListeners();
  //   });
  // }

  void navigateToNewBill(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const BillingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCirc;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

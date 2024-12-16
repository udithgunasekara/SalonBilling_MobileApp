import 'package:flutter/material.dart';
import 'package:salon_mobile/View/billingpage/add_client.dart';
import 'package:salon_mobile/View/billingpage/add_service.dart';
import 'package:salon_mobile/View/billingpage/charge_price.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Billing',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: mainColor,
        ),
        body: const Column(
          //mainAxisAlignment: MainAxisAlignment.,
          children: [
            //add client information widget here
            ClientInfor(),
            SizedBox(height: 20),
            //add service list widget here
            ServiceInfor()
          ],
        ));
  }
}

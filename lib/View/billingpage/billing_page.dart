import 'package:flutter/material.dart';
import 'package:salon_mobile/View/billingpage/add_client.dart';
import 'package:salon_mobile/View/billingpage/add_service.dart';
import 'package:salon_mobile/ViewModel/bill.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    ServiceViewModel viewModel = ServiceViewModel();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Bill().detach();
            viewModel.detach();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Billing',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: mainColor,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ClientInfor(),
            SizedBox(height: 20),
            ServiceInfor(),
          ],
        ),
      ),
    );
  }
}

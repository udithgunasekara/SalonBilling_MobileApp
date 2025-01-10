import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';

class ChargePrice extends StatefulWidget {
  const ChargePrice({super.key});

  @override
  State<ChargePrice> createState() => _ChargePriceState();
}

class _ChargePriceState extends State<ChargePrice> {
  final ServiceViewModel _viewModel = ServiceViewModel();

  String? x;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'Charge Price: Rs $x',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

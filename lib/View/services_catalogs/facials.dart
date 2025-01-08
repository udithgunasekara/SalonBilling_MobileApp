import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class Facials extends StatefulWidget {
  const Facials({super.key});

  @override
  _FacialsState createState() => _FacialsState();
}

class _FacialsState extends State<Facials> {
  final _viewModel = ServiceViewModel();
  int _selectedIndex = -1; // -1 means no selection
  String? selectedService; // To track the selected service

  void selectService(String text, int index) {
    setState(() {
      // If the same item is tapped again, deselect it
      if (_selectedIndex == index) {
        _selectedIndex = -1;
        selectedService = null;
      } else {
        _selectedIndex = index;
        selectedService = text;
      }
    });

    // Pass the selected service (or empty list if nothing selected)
    List<String> serviceList =
        selectedService != null ? [selectedService!] : [];
    _viewModel.passFinalValue("Facials", serviceList: serviceList);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Facials',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      height: 2.0,
                      width: 80,
                      color: mainColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _serviceButton('Dreamron', 0, fullWidth: true),
                const SizedBox(height: 16),
                _serviceButton('Jovees', 1, fullWidth: true),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _serviceButton('Gold', 2),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _serviceButton('Silver', 3),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _serviceButton('Pearl', 4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _serviceButton(String title, int index, {bool fullWidth = false}) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => selectService(title, index),
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

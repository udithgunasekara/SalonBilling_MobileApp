import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class CleanUps extends StatefulWidget {
  const CleanUps({super.key});

  @override
  _CleanUpsState createState() => _CleanUpsState();
}

class _CleanUpsState extends State<CleanUps> {
  final _viewModel = ServiceViewModel();
  int _selectedIndex = -1;
  String? selectedService;

  void selectService(String text, int index) {
    setState(() {
      if (_selectedIndex == index) {
        // Deselect if tapping the same item
        _selectedIndex = -1;
        selectedService = null;
      } else {
        // Select new item
        _selectedIndex = index;
        selectedService = text;
      }
    });

    // Update ViewModel with selected service or empty list
    List<String> serviceList =
        selectedService != null ? [selectedService!] : [];
    _viewModel.passFinalValue("Clean Ups", serviceList: serviceList);
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
                      'Clean Ups',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      height: 2.0,
                      width: 100,
                      color: mainColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _serviceButton(
                  title: 'Pack',
                  index: 0,
                ),
                const SizedBox(height: 16),
                _serviceButton(
                  title: 'Without Pack',
                  index: 1,
                  initiallySelected: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _serviceButton({
    required String title,
    required int index,
    bool initiallySelected = false,
  }) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => selectService(title, index),
      child: Container(
        width: double.infinity,
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

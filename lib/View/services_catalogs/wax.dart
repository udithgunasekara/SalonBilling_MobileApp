import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class Wax extends StatefulWidget {
  const Wax({super.key});

  @override
  _WaxState createState() => _WaxState();
}

class _WaxState extends State<Wax> {
  final _viewModel = ServiceViewModel();
  final List<bool> _isSelected = List.generate(2, (index) => false);
  List<String> selectedServices = [];

  void selectService(String text, int index) {
    setState(() {
      _isSelected[index] = !_isSelected[index];

      if (_isSelected[index]) {
        // Add service if selected
        if (!selectedServices.contains(text)) {
          selectedServices.add(text);
        }
      } else {
        // Remove service if deselected
        selectedServices.remove(text);
      }
    });

    // Update ViewModel with selected services
    _viewModel.passFinalValue("Wax", serviceList: selectedServices);
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
                      'Wax',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      height: 2.0,
                      width: 50,
                      color: mainColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _serviceButton(
                  title: 'Hands',
                  index: 0,
                ),
                const SizedBox(height: 16),
                _serviceButton(
                  title: 'Legs',
                  index: 1,
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
  }) {
    return GestureDetector(
      onTap: () => selectService(title, index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          color: _isSelected[index] ? Colors.blue.shade50 : Colors.white,
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

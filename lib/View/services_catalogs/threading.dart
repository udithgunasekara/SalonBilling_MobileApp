import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class Threading extends StatefulWidget {
  const Threading({super.key});

  @override
  _ThreadingState createState() => _ThreadingState();
}

class _ThreadingState extends State<Threading> {
  final _viewModel = ServiceViewModel();
  int _selectedIndex = -1;
  List<String> selectedServices = [];

  void selectService(String text) {
    setState(() {
      if (text == 'Full Face') {
        // If Full Face is selected, clear all other selections
        selectedServices = ['Full Face'];
      } else {
        // For other options
        if (selectedServices.contains('Full Face')) {
          // If Full Face was previously selected, clear it
          selectedServices.clear();
        }

        if (selectedServices.contains(text)) {
          // If service is already selected, remove it
          selectedServices.remove(text);
        } else {
          // Add the new service
          selectedServices.add(text);
        }
      }
    });

    _viewModel.passFinalValue("Threading", serviceList: selectedServices);
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
                      'Threading',
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
                  title: 'Full Face',
                ),
                const SizedBox(height: 16),
                _serviceButton(
                  title: 'Upper Lip',
                ),
                const SizedBox(height: 16),
                _serviceButton(
                  title: 'Eye Brows',
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
  }) {
    final bool isSelected = selectedServices.contains(title);

    return GestureDetector(
      onTap: () => selectService(title),
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

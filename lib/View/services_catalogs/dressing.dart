import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';

class Dressing extends StatefulWidget {
  const Dressing({super.key});

  @override
  _DressingState createState() => _DressingState();
}

class _DressingState extends State<Dressing> {
  final _viewModel = ServiceViewModel();
  List<bool> _isSelected = [false, false, false];
  List<String> servicers = [];

  //pass selected services
  void selectedServices(String text) {
    if (!servicers.contains(text)) {
      servicers.add(text);
    } else {
      servicers.remove(text);
    }
    print("Service List: $servicers");
    print("calling...");
    _viewModel.passFinalValue("Dressing", serviceList: servicers);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bridal Dressing',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      height: 2.0,
                      width: 120,
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _serviceButton(
                    'Hair Dressing', 0), // Pass the index for state tracking
                const SizedBox(height: 16),
                _serviceButton('Dress Dressing', 1),
                const SizedBox(height: 16),
                _serviceButton('MakeUp', 2),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _serviceButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            // Toggle the selected state of the clicked button
            _isSelected[index] = !_isSelected[index];

            print("Seletect Title: $title");
          },
        );
        print("JJJ");
        selectedServices(title);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
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

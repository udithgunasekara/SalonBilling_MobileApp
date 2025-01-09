import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class HairCut extends StatefulWidget {
  const HairCut({super.key});

  @override
  State<HairCut> createState() => _HairCutState();
}

class _HairCutState extends State<HairCut> {
  String? selectedOption;
  double price = 100.00;
  bool isEditing = false;
  final TextEditingController _priceController = TextEditingController();
  final _viewModel = ServiceViewModel();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _priceController.text = price.toString();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (isEditing) {
        price = double.tryParse(_priceController.text) ?? price;
        _viewModel.notifychanges(price.toInt().toString(), selectedOption);
      } else {
        _priceController.clear();
        Future.delayed(const Duration(milliseconds: 50), () {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hair Cut',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      height: 3.0,
                      width: 100,
                      color: mainColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // First row
                Row(
                  children: [
                    Expanded(
                      child: _buildOptionButton('1 Length'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOptionButton('U or V Cut'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Second row
                Row(
                  children: [
                    Expanded(
                      child: _buildOptionButton('Short Layer'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOptionButton('Long Layer'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Third row
                Row(
                  children: [
                    Expanded(
                      child: _buildOptionButton('Feather'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildOptionButton('Bob'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Please set a Price:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 240, 55, 42),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _toggleEdit,
                    child: isEditing
                        ? TextField(
                            controller: _priceController,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              contentPadding: EdgeInsets.only(left: 16),
                            ),
                            onSubmitted: (_) => _toggleEdit(),
                          )
                        : Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  price > 0 ? price.toStringAsFixed(2) : '',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton(String option) {
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
          _viewModel.notifychanges(price.toInt().toString(), selectedOption);
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? mainColor : Colors.blue.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? mainColor : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

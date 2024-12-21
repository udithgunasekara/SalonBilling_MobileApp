import 'package:flutter/material.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class ClientInfor extends StatelessWidget {
  const ClientInfor({super.key});

  @override
  Widget build(BuildContext context) {
    // Create controllers
    final TextEditingController clientNameController =
        TextEditingController(text: 'Bianca Cooper');
    final TextEditingController phoneNumberController =
        TextEditingController(text: '077 98 875 412');
    final TextEditingController locationController =
        TextEditingController(text: 'Wariyapola');

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        decoration: const BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Client Information,',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              cursorColor: Colors.white,
              controller: clientNameController,
              style: const TextStyle(color: mainTextColor, fontSize: 20),
              decoration: const InputDecoration(
                labelText: 'Client Name',
                labelStyle: TextStyle(fontSize: 20, color: mainTextColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              onTap: () {
                // Clear the text in the controller when the field is tapped
                clientNameController.clear();
              },
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: phoneNumberController,
              style: const TextStyle(color: mainTextColor, fontSize: 20),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'WhatsApp Number',
                labelStyle: TextStyle(fontSize: 20, color: mainTextColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              onTap: () {
                // Clear the text in the controller when the field is tapped
                phoneNumberController.clear();
              },
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: locationController,
              style: const TextStyle(color: mainTextColor, fontSize: 20),
              decoration: const InputDecoration(
                labelText: 'Location',
                labelStyle: TextStyle(fontSize: 20, color: mainTextColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              onTap: () {
                // Clear the text in the controller when the field is tapped
                locationController.clear();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle saving client information
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

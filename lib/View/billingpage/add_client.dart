import 'package:flutter/material.dart';
import 'package:salon_mobile/ViewModel/bill.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';
import 'package:salon_mobile/assets/theme/themeimages.dart';

class ClientInfor extends StatefulWidget {
  const ClientInfor({super.key});

  @override
  State<ClientInfor> createState() => _ClientInforState();
}

class _ClientInforState extends State<ClientInfor> {
  Bill bill = Bill();

  final TextEditingController clientNameController =
      TextEditingController(text: 'Bianca Cooper');
  final TextEditingController phoneNumberController =
      TextEditingController(text: '077 98 875 412');
  final TextEditingController locationController =
      TextEditingController(text: 'Wariyapola');

  @override
  void dispose() {
    clientNameController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void saveInputs() {
    final clientName = clientNameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final location = locationController.text.trim();

    //saving...
    print("clientName : $clientName");
    print("Phone number: $phoneNumber");
    print("Location: $location");

//setter values
    bill.setClientName = clientName;
    bill.setPhoneNumber = phoneNumber;
    bill.setLocation = location;
  }

  @override
  Widget build(BuildContext context) {
    // Create controllers

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        height: 340,
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
            // CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       "https://img.icons8.com/?size=100&id=BPvo4DAyjprS&format=png&color=000000"),
            //   radius: 25,
            // ),
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
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: saveInputs,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

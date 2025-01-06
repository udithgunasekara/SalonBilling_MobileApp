import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_mobile/ViewModel/bill.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

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
      TextEditingController(text: '0779887541');
  final TextEditingController locationController =
      TextEditingController(text: 'Wariyapola');

  // Error message variables
  String? clientNameError;
  String? phoneNumberError;
  String? locationError;
  bool haveWhatsApp = true;

  // Add flags to track if fields have been tapped
  bool _isClientNameTapped = false;
  bool _isPhoneNumberTapped = false;
  bool _isLocationTapped = false;

  @override
  void initState() {
    super.initState();
    // Initialize error states based on initial controller values
    clientNameError = validateClientName(clientNameController.text);
    phoneNumberError = validatePhoneNumber(phoneNumberController.text);
    locationError = validateLocation(locationController.text);
  }

  @override
  void dispose() {
    clientNameController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
    super.dispose();
  }

  // Validation functions
  String? validateClientName(String value) {
    if (value.trim().isEmpty) {
      return 'Client Name is required';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.trim().isEmpty) {
      return 'WhatsApp Number is required';
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Enter a valid phone number';
    } else if (value.trim().length != 10) {
      return 'Phone number must be exactly 10 digits';
    }
    return null;
  }

  String? validateLocation(String value) {
    if (value.trim().isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  // Update error states based on input
  void updateClientName(String value) {
    setState(() {
      clientNameError = validateClientName(value);
      bill.setClientName = value.trim();
    });
  }

  void updatePhoneNumber(String value) {
    setState(() {
      phoneNumberError = validatePhoneNumber(value);
      bill.setPhoneNumber = value.trim();
    });
  }

  void updateLocation(String value) {
    setState(() {
      locationError = validateLocation(value);
      bill.setLocation = value.trim();
    });
  }

  void updateWhatsAppStatus(bool value) {
    setState(() {
      bill.setWhatsAppStatus = value;
      print("Whatsapp Statusss: $haveWhatsApp");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 340,
        decoration: const BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Form(
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
              const SizedBox(height: 10.0),
              // Client Name Field
              TextFormField(
                cursorColor: Colors.white,
                controller: clientNameController,
                style: const TextStyle(color: mainTextColor, fontSize: 20),
                onTap: () {
                  if (!_isClientNameTapped) {
                    setState(() {
                      clientNameController.clear();
                      _isClientNameTapped = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Client Name',
                  labelStyle:
                      const TextStyle(fontSize: 20, color: mainTextColor),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  errorText: clientNameError,
                  suffixIcon: clientNameError == null
                      ? const Icon(Icons.check_circle,
                          color: secondaryColor, size: 30)
                      : const Icon(Icons.error, color: errorColor, size: 30),
                ),
                onChanged: updateClientName,
              ),
              const SizedBox(height: 10.0),
              // WhatsApp Number Field
              TextFormField(
                controller: phoneNumberController,
                style: const TextStyle(color: mainTextColor, fontSize: 20),
                keyboardType: TextInputType.number,
                onTap: () {
                  if (!_isPhoneNumberTapped) {
                    setState(() {
                      phoneNumberController.clear();
                      _isPhoneNumberTapped = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'WhatsApp Number',
                  labelStyle:
                      const TextStyle(fontSize: 20, color: mainTextColor),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  errorText: phoneNumberError,
                  suffixIcon: phoneNumberError == null
                      ? const Icon(Icons.check_circle,
                          color: secondaryColor, size: 30)
                      : const Icon(Icons.error, color: errorColor, size: 30),
                ),
                onChanged: updatePhoneNumber,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Haven't WhatsApp? ",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      haveWhatsApp
                          ? 'assets/whatsappsvg.svg'
                          : 'assets/redwhatsappsvg.svg',
                      height: 30.0,
                      width: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        print("Values");
                        haveWhatsApp = !haveWhatsApp;
                        updateWhatsAppStatus(haveWhatsApp);
                      });
                    },
                  ),
                ],
              ),
              // Location Field
              TextFormField(
                controller: locationController,
                style: const TextStyle(color: mainTextColor, fontSize: 20),
                onTap: () {
                  if (!_isLocationTapped) {
                    setState(() {
                      locationController.clear();
                      _isLocationTapped = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle:
                      const TextStyle(fontSize: 20, color: mainTextColor),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  errorText: locationError,
                  suffixIcon: locationError == null
                      ? const Icon(
                          Icons.check_circle,
                          color: secondaryColor,
                          size: 30,
                        )
                      : const Icon(Icons.error, color: errorColor, size: 30),
                ),
                onChanged: updateLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

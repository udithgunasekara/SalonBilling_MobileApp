//stateless
import 'package:flutter/material.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class ClientInfor extends StatelessWidget {
  const ClientInfor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(height: 20.0),
          TextField(
            controller: TextEditingController(text: 'Bianca Cooper'),
            style: const TextStyle(color: mainTextColor, fontSize: 20),
            decoration: const InputDecoration(
              labelText: 'Client Name',
              labelStyle: TextStyle(fontSize: 20, color: mainTextColor),
              //we can have to add underline border or outline border like wise. check them later on ....
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: TextEditingController(text: '077 98 875 412'),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'WhatsApp Number',
              labelStyle: TextStyle(fontSize: 22, color: mainTextColor),
              // border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: TextEditingController(text: 'Wariyapola'),
            decoration: const InputDecoration(
              labelText: 'Location',
              labelStyle: TextStyle(fontSize: 22, color: mainTextColor),

              // border: OutlineInputBorder(),
            ),
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
    );
  }
}

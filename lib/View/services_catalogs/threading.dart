import 'package:flutter/material.dart';

class Threading extends StatelessWidget {
  const Threading({super.key});

  //price is 400 and its fixed

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Color(0xFFBBDEFB), // Equivalent to Colors.blue.shade100
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Threading : 400",
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}

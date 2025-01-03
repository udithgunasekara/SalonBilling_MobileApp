import 'package:flutter/material.dart';
import 'package:salon_mobile/assets/theme/themebutton.dart';

import '../../assets/theme/themecolor.dart';
import 'package:salon_mobile/View/serivce_title.dart';
import 'package:salon_mobile/ViewModel/home_view_model.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _viewModel;

  const HomeView(this._viewModel, {super.key});

  // const HomeView({super.key});

  //TODO: separte date time functions in acc MVVM

  String getCurrentMonth() {
    final now = DateTime.now();
    final formatter = DateFormat('MMM yy');
    return formatter.format(now); // Format current date to "MMM yy"
  }

  List<String> getCurrentWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(
        days:
            now.weekday - 1)); // Get the first day of the current week (Monday)
    List<String> weekDays = [];
    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final formatter = DateFormat('d'); // Format the date to show day number
      weekDays.add(formatter.format(day));
    }
    return weekDays;
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = DateTime.now().day.toString(); // Get the current day
    // final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 320,
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello, Udith",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Display current month
                Text(
                  getCurrentMonth(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 10),
                // Display days of the current week in a horizontal list
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Distribute space evenly
                  children: getCurrentWeek().map((day) {
                    bool isCurrentDay =
                        day == currentDay; // Check if it's the current day
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: MediaQuery.of(context).size.width / 7 - 10,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isCurrentDay ? Colors.yellow : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: isCurrentDay
                            ? null
                            : Border.all(
                                color:
                                    mainColor), // Blue border for non-current days
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: isCurrentDay
                                ? Colors.white
                                : Colors
                                    .blueAccent, // White text for current day, blue for others
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _viewModel.services.length,
              itemBuilder: (context, index) {
                return ServiceTile(_viewModel.services[index]);
              },
            ),
          ),

          // Custom theme button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ThemeButton(
              text: 'Add New Bill',
              onPressed: () {
                _viewModel.navigateToNewBill(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

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

  List<Map<String, String>> getCurrentWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    List<Map<String, String>> weekDays = [];

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final dayNumber = DateFormat('d').format(day);
      final dayName = DateFormat('E')
          .format(day)
          .substring(0, 3); // Get first 3 letters of day name
      weekDays.add({
        'number': dayNumber,
        'name': dayName,
      });
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
                  '${getCurrentMonth()},',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 3),
                // Display days of the current week in a horizontal list
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getCurrentWeek().map((day) {
                    bool isCurrentDay = day['number'] == currentDay;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: MediaQuery.of(context).size.width / 7 - 10,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8), // Reduced padding to fit both texts
                      decoration: BoxDecoration(
                        color: isCurrentDay ? yellowColor : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            isCurrentDay ? null : Border.all(color: mainColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day['name']!, // Show day name
                            style: TextStyle(
                              color: isCurrentDay
                                  ? Colors.white
                                  : Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            day['number']!, // Show day number
                            style: TextStyle(
                              color: isCurrentDay
                                  ? Colors.white
                                  : Colors.blueAccent,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                return ServiceTile(
                  _viewModel.services[index],
                  index: index,
                );
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

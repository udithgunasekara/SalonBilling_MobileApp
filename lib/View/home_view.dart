import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/assets/theme/themebutton.dart';
import '../../assets/theme/themecolor.dart';
import 'package:salon_mobile/View/serivce_title.dart';
import 'package:salon_mobile/ViewModel/home_view_model.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _viewModel;

  const HomeView(this._viewModel, {super.key});

  String getCurrentMonth() {
    final now = DateTime.now();
    final formatter = DateFormat('MMM yy');

    return formatter.format(now);
  }

  List<Map<String, String>> getCurrentWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    List<Map<String, String>> weekDays = [];

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final dayNumber = DateFormat('d').format(day);
      final dayName = DateFormat('E').format(day).substring(0, 3);
      weekDays.add({
        'number': dayNumber,
        'name': dayName,
      });
    }
    return weekDays;
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = DateTime.now().day.toString();

    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
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
                        "Hello, Dilini",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('assets/dp1.jpg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${getCurrentMonth()},',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getCurrentWeek().map((day) {
                      bool isCurrentDay = day['number'] == currentDay;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: MediaQuery.of(context).size.width / 7 - 10,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isCurrentDay ? yellowColor : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: isCurrentDay
                              ? null
                              : Border.all(color: mainColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day['name']!,
                              style: TextStyle(
                                color: isCurrentDay
                                    ? Colors.white
                                    : Colors.blueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              day['number']!,
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
            StreamBuilder<List<Service>>(
              stream: _viewModel.servicesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('No bills available'),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ServiceTile(
                        snapshot.data![index],
                        index: index,
                      );
                    },
                  ),
                );
              },
            ),
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
      ),
    );
  }
}

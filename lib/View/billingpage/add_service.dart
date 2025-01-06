//statefull

//including search function and selected widget shower

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_mobile/View/billingpage/charge_price.dart';
import 'package:salon_mobile/View/services_catalogs/dressing.dart';
import 'package:salon_mobile/View/services_catalogs/threading.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themebutton.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';
import 'package:salon_mobile/assets/theme/toastbanner.dart';
import 'package:toastification/toastification.dart';

class ServiceInfor extends StatefulWidget {
  const ServiceInfor({super.key});

  @override
  State<ServiceInfor> createState() => _ServiceInforState();
}

class _ServiceInforState extends State<ServiceInfor> {
  final SearchController _searchController = SearchController();

  final ServiceViewModel _viewModel = ServiceViewModel();

  List<Map<String, dynamic>> _filteredServices = [];
  Widget? _selectedCalalogWidget;
  bool notifierPrice = false;

  String? controllerString;
  String? currentPrice = "____";
  String price = '0';

  @override
  void initState() {
    super.initState();
    _fetchServices();

    //Clean search bar
    // _searchController.addListener(() {
    //   _searchController.clear();
    // });

    //Lets set threading card first
  }
  //Clean search bar

  Future<void> _handleBackNavigation(BuildContext context) async {
    // Force hide keyboard using system channel
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    await Future.delayed(const Duration(milliseconds: 50));
    _searchController.clear();
    _searchController.closeView('');
    // FocusScope.of(context).unfocus();
  }

  Future<void> _fetchServices() async {
    await _viewModel.fetchAndSaveServices();
    setState(() {
      _filteredServices = _viewModel.services;
    });
  }

  //Filtering
  void _onSearchChnaged(String query) {
    setState(() {
      _filteredServices = _viewModel.searchServices(query);
    });
  }

//set service catalog
  void showCatalog(String text) {
    notifierPrice = true;
    setState(() {
      _selectedCalalogWidget = _viewModel.showSelectedService(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return
    // ValueListenableBuilder(
    //     valueListenable: _viewModel.defualPrice,
    //     builder: (context, price, child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///sorting algo for emp frquently used services
          const Text(
            "Add Service",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SearchAnchor.bar(
              searchController: _searchController,
              barHintText: 'Search for services...',
              viewHintText: 'Type to search services',
              barLeading: const Icon(Icons.search, color: Colors.grey),
              viewLeading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _handleBackNavigation(context),

                ///
              ),
              viewTrailing: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
              ],
              viewConstraints: const BoxConstraints(maxHeight: 350),
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                final suggestion = _viewModel.searchServices(controller.text);

                if (suggestion.isEmpty) {
                  return [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'No services found',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ];
                }

                return suggestion.map((service) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: mainColor.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE0E0E0),
                        child: Icon(Icons.spa, color: mainColor),
                      ),
                      title: Text(
                        service['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: mainColor,
                      ),
                      onTap: () {
                        controller.closeView(service['name']);
                        FocusScope.of(context).unfocus();
                        controllerString = controller.text;
                        showCatalog(controller.text);
                      },
                    ),
                  );
                }).toList();
              },
              onTap: () {
                if (_searchController.text == controllerString) {
                  _searchController.clear();
                }
              },
            ),
          ),

          SizedBox(height: 30),
          //showing catalog
          //Have some functions to implement
          //show Wvalue widget in there
          if (_selectedCalalogWidget != null)
            _selectedCalalogWidget!
          //when the user select price or widget return defualt price it should need to catch
          // the billing charge price widget
          else
            const Text(
              "Please select a service to see the catalog.",
              style: TextStyle(fontSize: 16),
            ),
          // i need to push below container into the buttom of the cr
          SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Charge Price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: buttonText,
                  ),
                ),
                notifierPrice
                    ? ValueListenableBuilder<String>(
                        valueListenable: _viewModel.defualPrice,
                        builder: (context, price, child) {
                          return Text(
                            price == '0' ? 'Rs. 0.00' : 'Rs. ${price}.00',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: buttonText,
                            ),
                          );
                        },
                      )
                    : const Text(
                        'Rs. 0.00',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: buttonText,
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ThemeButton(
              text: "Confirm Bill",
              onPressed: () async {
                try {
                  await _viewModel.saveBill();
                  // Show success toast
                  // Show success toast
                  // Show success toast
                  ToastHelper.toastBanner(
                    context,
                    "Billing Success",
                    ToastType.success,
                    duration: Duration(seconds: 3),
                    alignment: Alignment.bottomCenter,
                  );
                } catch (e) {
                  ToastHelper.toastBanner(
                    context,
                    "Please Check Informations again",
                    ToastType.error,
                    duration: Duration(seconds: 3),
                    alignment: Alignment.bottomCenter,
                  );
                }
              }),
        ],
      ),
    );
  }
  // );
  //}
}

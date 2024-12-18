//statefull

//including search function and selected widget shower

import 'package:flutter/material.dart';
import 'package:salon_mobile/View/billingpage/charge_price.dart';
import 'package:salon_mobile/View/services_catalogs/dressing.dart';
import 'package:salon_mobile/View/services_catalogs/threading.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';

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

  String? controllerString;
  String? currentPrice = "____";

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

  void callPrice() {
    setState(() {
      currentPrice = _viewModel.defualPrice; // Update the state
      print("Retured Price : $currentPrice");
    });
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
    setState(() {
      _selectedCalalogWidget = _viewModel.showSelectedService(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ///sorting algo for emp frquently used services
          SearchAnchor.bar(
            searchController: _searchController,
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              final suggestion = _viewModel.searchServices(controller.text);
              return suggestion.map((service) {
                return ListTile(
                  title: Text(service['name']),
                  onTap: () {
                    controller.closeView(service['name']);
                    FocusScope.of(context).unfocus();

                    controllerString = controller.text;
                    //call function
                    showCatalog(controller.text);
                    callPrice();
                  },
                );
              }).toList();
            },
            onTap: () {
              if (_searchController.text == controllerString) {
                _searchController.clear();
              }
            },
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
          SizedBox(height: 70),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Charge Pricee: Rs $currentPrice',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

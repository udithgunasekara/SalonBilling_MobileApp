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
  Widget? _selectedCalalogWidget = const Dressing();

  String? controllerString;
  String? currentPrice;

  @override
  void initState() {
    super.initState();
    _fetchServices();

    //Lets set threading card first
  }

  void callPrice() {
    setState(() {
      currentPrice = _viewModel.defualPrice; // Update the state
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
    return Column(
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
                  controllerString = controller.text;
                  //call function
                  showCatalog(controller.text);
                  callPrice();
                },
              );
            }).toList();
          },
        ),
        ElevatedButton(
            onPressed: () {
              print("Here Text: $controllerString");
            },
            child: Text("Print what i clicked")),
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
    );
  }
}

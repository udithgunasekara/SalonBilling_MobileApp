//statefull

//including search function and selected widget shower

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';
import 'package:salon_mobile/assets/theme/themebutton.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';
import 'package:salon_mobile/assets/theme/toastbanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceInfor extends StatefulWidget {
  const ServiceInfor({super.key});

  @override
  State<ServiceInfor> createState() => _ServiceInforState();
}

class _ServiceInforState extends State<ServiceInfor> {
  //Creating frequent list

  // Add these constants
  static const int _MAX_FREQUENCY = 50; // Maximum frequency count per service
  static const int _MAX_SERVICES = 20; // Maximum number of services to track
  static const Duration _RESET_DURATION =
      Duration(days: 30); // Reset after 30 days

  // Add these new variables
  final Map<String, int> _serviceFrequency = {};
  final String _prefsKey = 'service_frequencies';
  final String _lastResetKey = 'last_reset_date';

  // Load frequencies with auto-reset check
  Future<void> _loadServiceFrequencies() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if reset is needed
      final lastReset = prefs.getString(_lastResetKey);
      if (lastReset != null) {
        final lastResetDate = DateTime.parse(lastReset);
        if (DateTime.now().difference(lastResetDate) >= _RESET_DURATION) {
          await _resetFrequencies();
          return;
        }
      } else {
        await prefs.setString(_lastResetKey, DateTime.now().toIso8601String());
      }

      // Load existing frequencies
      final frequencies = prefs.getStringList(_prefsKey) ?? [];
      for (var freq in frequencies) {
        final parts = freq.split(':');
        if (parts.length == 2) {
          _serviceFrequency[parts[0]] = int.parse(parts[1]);
        }
      }

      if (_serviceFrequency.length > _MAX_SERVICES) {
        _cleanupOldFrequencies();
      }
    } catch (e) {
      print('Error loading frequencies: $e');
    }
  }

  // Reset frequencies automatically
  Future<void> _resetFrequencies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
      await prefs.setString(_lastResetKey, DateTime.now().toIso8601String());
      _serviceFrequency.clear();
    } catch (e) {
      print('Error resetting frequencies: $e');
    }
  }

  // Save frequencies with limitations
  Future<void> _saveServiceFrequencies() async {
    try {
      if (_serviceFrequency.length > _MAX_SERVICES) {
        _cleanupOldFrequencies();
      }

      final prefs = await SharedPreferences.getInstance();
      final frequencies =
          _serviceFrequency.entries.map((e) => '${e.key}:${e.value}').toList();
      await prefs.setStringList(_prefsKey, frequencies);
    } catch (e) {
      print('Error saving frequencies: $e');
    }
  }

  // Modified showCatalog with frequency limit
  void showCatalog(String text) {
    notifierPrice = true;

    // Update frequency with limit check
    int currentFreq = _serviceFrequency[text] ?? 0;
    if (currentFreq < _MAX_FREQUENCY) {
      _serviceFrequency[text] = currentFreq + 1;
      _saveServiceFrequencies();
    }

    setState(() {
      _selectedCalalogWidget = _viewModel.showSelectedService(text);
    });
  }

  // Cleanup method for maintaining service limit
  void _cleanupOldFrequencies() {
    if (_serviceFrequency.isEmpty) return;

    var sortedServices = _serviceFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    _serviceFrequency.clear();
    for (var i = 0; i < _MAX_SERVICES && i < sortedServices.length; i++) {
      _serviceFrequency[sortedServices[i].key] = sortedServices[i].value;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadServiceFrequencies(); // Add this line
    _fetchServices();
  }

  //--------------------------------------------------------------------------------
  //--------------------------------------------------------------------------------

  final SearchController _searchController = SearchController();

  final ServiceViewModel _viewModel = ServiceViewModel();

  List<Map<String, dynamic>> _filteredServices = [];
  Widget? _selectedCalalogWidget;
  bool notifierPrice = false;

  String? controllerString;
  String? currentPrice = "____";
  String price = '0';

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchServices();
  // }
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
  // void showCatalog(String text) {
  //   notifierPrice = true;
  //   setState(() {
  //     _selectedCalalogWidget = _viewModel.showSelectedService(text);
  //   });
  // }

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
          const SizedBox(
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

                // Sort suggestions based on frequency
                suggestion.sort((a, b) {
                  final freqA = _serviceFrequency[a['name']] ?? 0;
                  final freqB = _serviceFrequency[b['name']] ?? 0;
                  return freqB.compareTo(freqA); // Sort in descending order
                });

                return suggestion.map((service) {
                  // Get frequency count for this service
                  //final frequency = _serviceFrequency[service['name']] ?? 0;

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
                      // Add subtitle to show frequency (optional)

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

              // suggestionsBuilder:
              //     (BuildContext context, SearchController controller) {
              //   final suggestion = _viewModel.searchServices(controller.text);

              //   if (suggestion.isEmpty) {
              //     return [
              //       const Center(
              //         child: Padding(
              //           padding: EdgeInsets.all(20),
              //           child: Text(
              //             'No services found',
              //             style: TextStyle(
              //               color: Colors.grey,
              //               fontSize: 16,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ];
              //   }

              //   return suggestion.map((service) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(
              //             color: mainColor.withOpacity(0.1),
              //             width: 1,
              //           ),
              //         ),
              //       ),
              //       child: ListTile(
              //         leading: const CircleAvatar(
              //           backgroundColor: Color(0xFFE0E0E0),
              //           child: Icon(Icons.spa, color: mainColor),
              //         ),
              //         title: Text(
              //           service['name'],
              //           style: const TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         trailing: const Icon(
              //           Icons.arrow_forward_ios,
              //           size: 16,
              //           color: mainColor,
              //         ),
              //         onTap: () {
              //           controller.closeView(service['name']);
              //           FocusScope.of(context).unfocus();
              //           controllerString = controller.text;
              //           showCatalog(controller.text);
              //         },
              //       ),
              //     );
              //   }).toList();
              // },
              onTap: () {
                if (_searchController.text == controllerString) {
                  _searchController.clear();
                }
              },
            ),
          ),

          const SizedBox(height: 30),
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
          const SizedBox(height: 10),

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
                            price == '0' ? 'Rs. 0.00' : 'Rs. $price.00',
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
          const SizedBox(height: 10),
          ThemeButton(
              text: "Confirm Bill",
              // Update the onPressed callback
              onPressed: () async {
                try {
                  await _viewModel.saveBill();
                  ToastHelper.toastBanner(
                    context,
                    "Billing Success",
                    ToastType.success,
                    duration: const Duration(seconds: 2),
                    alignment: Alignment.bottomCenter,
                  );
                } catch (e) {
                  ToastHelper.toastBanner(
                    context,
                    "Please Check Informations again",
                    ToastType.error,
                    duration: const Duration(seconds: 3),
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

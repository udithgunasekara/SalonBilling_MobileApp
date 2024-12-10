//statefull
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';

class ServiceInfor extends StatefulWidget {
  const ServiceInfor({super.key});

  @override
  State<ServiceInfor> createState() => _ServiceInforState();
}

class _ServiceInforState extends State<ServiceInfor> {
  final SearchController _searchController = SearchController();
  //final TextEditingController _searchController = TextEditingController();

  String? controllerString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final serviceViewModel =
        Provider.of<ServiceViewModel>(context, listen: false);
    serviceViewModel
        .fetchAndSaveServices(); // Fetch services when View is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceViewModel>(
      builder: (context, serviceViewModel, child) {
        return Column(
          children: [
            // Search bar to filter services
            SearchAnchor.bar(
              searchController: _searchController,
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                final query = controller.text.toLowerCase();
                final suggestions = serviceViewModel.services
                    .where((service) =>
                        service['name'].toLowerCase().contains(query))
                    .toList();

                return List<ListTile>.generate(suggestions.length, (int index) {
                  final service = suggestions[index];
                  return ListTile(
                    title: Text(service['name']),
                    onTap: () {
                      controller.closeView(service['name']);
                      controllerString = service['name'];
                      print("Selected Service: $controllerString");
                    },
                  );
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  print("Selected Service: $controllerString");
                },
                child: Text("Print Selected Service"))
          ],
        );
      },
    );
  }
}

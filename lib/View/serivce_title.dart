import 'package:flutter/material.dart';
import 'package:salon_mobile/Model/service.dart';

//showing the service employee did
class ServiceTile extends StatelessWidget {
  final Service _service;

  const ServiceTile(this._service, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_service.providerName),
      subtitle: Text(_service.serviceType),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(_service.contactNumber),
          Text('Rs. ${_service.price}/-'),
        ],
      ),
    );
  }
}

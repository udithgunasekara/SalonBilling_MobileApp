import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_mobile/Model/service.dart';
import 'package:salon_mobile/ViewModel/service_view_model.dart';

class HomeRepositoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Service>> getBills() {
    try {
      return _firestore.collection('Bills').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          try {
            print('Processing document ${doc.id}');
            print('Raw data: ${doc.data()}');
            return Service.fromSnapshot(doc);
          } catch (e) {
            print('Error parsing document ${doc.id}: $e');
            return Service(
              providerName: 'Error',
              serviceType: '',
              contactNumber: 'Error',
              time: 'Error',
              price: '',
            );
          }
        }).toList();
      });
    } catch (e) {
      print('Error in getBills: $e');
      return Stream.value([]);
    }
  }
}

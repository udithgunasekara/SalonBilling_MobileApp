import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_mobile/Model/service.dart';

class HomeRepositoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Service>> getBills() {
    try {
      return _firestore.collection('Bills').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          try {
            return Service.fromSnapshot(doc);
          } catch (e) {
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
      return Stream.value([]);
    }
  }
}

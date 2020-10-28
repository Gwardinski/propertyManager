import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_manager/models/property_model.dart';

class PropertyCollectionService {
  final CollectionReference _propertiesCollection =
      FirebaseFirestore.instance.collection('properties');

  Stream<List<PropertyModel>> getAllProperties() {
    return _propertiesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PropertyModel.fromFirebase(doc)).toList();
    });
  }

  Stream<List<PropertyModel>> getPropertiesByIds({List<String> ids}) {
    if (ids.length == 0) return null;
    return _propertiesCollection.where("id", whereIn: ids).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PropertyModel.fromFirebase(doc)).toList();
    });
  }
}

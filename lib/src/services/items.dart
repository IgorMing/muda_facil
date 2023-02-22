import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsService {
  final DocumentReference doc =
      FirebaseFirestore.instance.collection('static').doc('items');

  Future<List<dynamic>> getAll() async {
    var response = (await doc.get()).data() as Map;
    return response.values.first;
  }
}

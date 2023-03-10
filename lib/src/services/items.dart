import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsService {
  final DocumentReference doc =
      FirebaseFirestore.instance.collection('items').doc('list');

  Future<List<String>> getAll() async {
    final response = await doc.get();
    final mapResponse = response.data() as Map<String, dynamic>;
    return mapResponse['data'].cast<String>();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/models/storage_items_response.dart';

class ItemsService {
  final DocumentReference doc =
      FirebaseFirestore.instance.collection('static').doc('items');

  Future<StorageItemsResponse> getAll() async {
    final response = await doc.get();
    return StorageItemsResponse.fromJson(
        response.data() as Map<String, dynamic>);
  }
}

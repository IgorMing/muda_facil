import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/features/items/models/autocomplete_list.dart';

class ItemsService {
  late final CollectionReference<AutocompleteList> _collection;
  late final Stream<AutocompleteList?> listStream;

  ItemsService() {
    _collection = FirebaseFirestore.instance.collection('items').withConverter(
          fromFirestore: (snapshot, options) =>
              AutocompleteList.fromJson(snapshot.data()),
          toFirestore: (value, options) => value.toJson(),
        );

    listStream =
        _collection.doc('list').snapshots().map((event) => event.data());
  }
}

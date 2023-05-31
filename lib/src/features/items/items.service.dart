import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/features/items/models/autocomplete_list.dart';

class ItemsService {
  late final CollectionReference<AutocompleteList> _collection;
  late final Stream<AutocompleteList?> listStream;
  late final Stream<AutocompleteList?> candidatesStream;

  ItemsService() {
    _collection = FirebaseFirestore.instance.collection('items').withConverter(
          fromFirestore: (snapshot, options) =>
              AutocompleteList.fromJson(snapshot.data()),
          toFirestore: (value, options) => value.toJson(),
        );

    listStream =
        _collection.doc('list').snapshots().map((event) => event.data());

    candidatesStream =
        _collection.doc('candidates').snapshots().map((event) => event.data());
  }

  checkCandidates(List<String> items) async {
    final listCollection = await _collection.doc('list').get();
    final list = listCollection.data()!;

    final difference = items.toSet().difference(list.data.toSet());

    final candidatesCollection = await _collection.doc('candidates').get();
    final AutocompleteList candidates = candidatesCollection.data()!;

    candidates.data.addAll(difference);
    await _collection.doc('candidates').set(candidates);
  }

  setCandidates(List<String> candidates) {
    _collection.doc('candidates').set(AutocompleteList.fromList(candidates));
  }
}

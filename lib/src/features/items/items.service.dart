import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
    final list = listCollection.data()!.data;

    final Set<String> difference = items.toSet().difference(list.toSet());

    if (difference.isNotEmpty) {
      final candidatesCollection = await _collection.doc('candidates').get();
      final AutocompleteList candidates = candidatesCollection.data()!;

      candidates.data.addAll(difference);
      await _collection.doc('candidates').set(candidates);
      await FirebaseAnalytics.instance.logEvent(
          name: 'new_candidate_items',
          parameters: {
            "amount": difference.length,
            "data": difference.toString()
          });
    }
  }

  setCandidates(List<String> value) {
    _collection.doc('candidates').set(AutocompleteList.fromList(value));
  }

  deleteCandidate(String value) async {
    final candidatesCollection = await _collection.doc('candidates').get();
    final list = candidatesCollection.data()!.data;
    list.remove(value);

    await _collection.doc('candidates').set(AutocompleteList.fromList(list));
  }

  approveCandidate(String value) async {
    final listCollection = await _collection.doc('list').get();
    final list = listCollection.data()!.data;
    list.add(value);

    await deleteCandidate(value);
    await _collection.doc('list').set(AutocompleteList.fromList(list));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/models/moving_order.dart';

class OrdersService {
  late final Query<MovingOrder> _collection;
  late final Stream<List<MovingOrder>> _stream;

  OrdersService() {
    _collection = FirebaseFirestore.instance
        .collectionGroup('orders')
        .withConverter(
          fromFirestore: (snapshot, _) => MovingOrder.fromJson(snapshot.data()),
          toFirestore: (MovingOrder value, _) => value.toJson(),
        );

    _stream = _collection.snapshots().map((event) {
      List<MovingOrder> list = [];
      for (final doc in event.docs) {
        list.add(doc.data());
      }
      return list;
    });
  }

  Stream<List<MovingOrder>> get stream => _stream;
}

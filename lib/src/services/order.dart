import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muda_facil/src/models/moving_order.dart';

class OrderService {
  final User? user = FirebaseAuth.instance.currentUser;
  late final CollectionReference<MovingOrder> collection;
  late final Stream<MovingOrder?> _stream;

  OrderService() {
    if (user == null) return;

    collection = FirebaseFirestore.instance
        .collection("users/${user!.uid}/orders")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MovingOrder.fromJson(snapshot.data()),
          toFirestore: (MovingOrder value, _) => value.toJson(),
        );

    _stream = collection.snapshots().map((event) {
      if (event.docs.isNotEmpty) {
        return event.docs[0].data();
      }

      return null;
    });
  }

  Stream<MovingOrder?> getStream() {
    return _stream;
  }

  Future<QuerySnapshot<MovingOrder>> _getLastOrder() {
    // add orderBy createdAt desc in the future
    return collection.limit(1).get();
  }

  Future<void> setOrder(MovingOrder order) async {
    final snapshot = await _getLastOrder();
    if (snapshot.docs.isEmpty) {
      // add
      await collection.add(order);
    } else {
      // update
      await setOrderById(snapshot.docs[0].id, order);
    }
  }

  Future<void> setOrderById(String uid, MovingOrder order) {
    final docRef = collection.doc(uid);
    return docRef.set(order);
  }

  Future<void> deleteOrder() async {
    final snapshot = await _getLastOrder();
    if (snapshot.docs.isNotEmpty) {
      await collection.doc(snapshot.docs[0].id).delete();
    }
  }
}

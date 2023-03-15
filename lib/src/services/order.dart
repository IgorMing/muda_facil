import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muda_facil/src/models/moving_order.dart';

class OrderService {
  final User user = FirebaseAuth.instance.currentUser as User;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late final CollectionReference<MovingOrder> collection;

  OrderService() {
    collection = db.collection("users/${user.uid}/orders").withConverter(
          fromFirestore: (snapshot, options) =>
              MovingOrder.fromJson(snapshot.data()),
          toFirestore: (MovingOrder value, _) => value.toJson(),
        );
  }

  Future<QuerySnapshot<MovingOrder>> _getLastOrder() {
    // add orderBy createdAt desc in the future
    return collection.limit(1).get();
  }

  Future<MovingOrder?> getOrder() async {
    // this gets always the first record. initially, we'll consider that
    // each user will have only one order. If we need to care about another,
    // nice! Things are going well with the product :)
    final docs = await _getLastOrder();
    if (docs.docs.isNotEmpty) {
      return docs.docs[0].data();
    }
    return null;
  }

  Future<void> setOrder(MovingOrder order) async {
    final existentOrder = await _getLastOrder();
    if (existentOrder.docs.isEmpty) {
      await collection.add(order);
    } else {
      // TODO: continue from here
      // check how to update the order properly!
      final docRef = existentOrder.docs[0];
      // db.runTransaction((transaction) {
      //   transaction.update(docRef, {});
      // });
    }
  }
}

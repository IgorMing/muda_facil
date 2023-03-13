import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muda_facil/src/models/moving_order.dart';

class OrderService {
  final User user = FirebaseAuth.instance.currentUser as User;
  late final CollectionReference<MovingOrder> collection;

  OrderService() {
    collection = FirebaseFirestore.instance
        .collection("users/${user.uid}/orders")
        .withConverter(
          fromFirestore: MovingOrder.fromFirestore,
          toFirestore: (MovingOrder value, _) => value.toFirestore(),
        );
  }

  Future<MovingOrder?> getOrder() async {
    // this gets always the first record. initially, we'll consider that
    // each user will have only one order. If we need to care about another,
    // nice! Things are going well with the product :)
    final docs = await collection.limit(1).get();
    if (docs.docs.isNotEmpty) {
      return docs.docs[0].data();
    }
    return null;
  }

  Future<void> setOrder(MovingOrder order) async {
    await collection.add(order);
  }
}

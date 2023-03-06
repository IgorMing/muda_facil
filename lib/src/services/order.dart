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

  Future<MovingOrder> getOrder() async {
    final docs = await collection.limit(1).get();
    return docs.docs[0].data();
  }

  Future<void> setOrder(Order order) async {
    // collection.
  }
}

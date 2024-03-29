import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/models/moving_order.dart';
import 'package:muda_facil/src/services/auth.dart';
import 'package:muda_facil/src/utils/constants.dart';

class OrdersService {
  late final Query<MovingOrder> _collection;
  late final Stream<List<MovingOrderWithRef>> _stream;
  final AuthService authService = AuthService();

  OrdersService() {
    _collection = FirebaseFirestore.instance
        .collectionGroup('orders')
        .withConverter(
          fromFirestore: (snapshot, _) => MovingOrder.fromJson(snapshot.data()),
          toFirestore: (MovingOrder value, _) => value.toJson(),
        );

    _stream = _collection.snapshots().map((event) {
      List<MovingOrderWithRef> list = [];
      for (final doc in event.docs) {
        // final id = doc.reference.parent.parent!.id;
        // await authService.getUserInfo(uid: id);
        list.add(MovingOrderWithRef(order: doc.data(), ref: doc.reference));
      }
      return list;
    });
  }

  Stream<List<MovingOrderWithRef>> get stream => _stream;

  setBudget(
    DocumentReference<MovingOrder> ref, {
    required double value,
    required String driver,
    required String pixCode,
  }) {
    ref.update({
      "budgetValue": value,
      "driverName": driver,
      "pixCode": pixCode,
      "status": OrderStatus.waitingApproval.name,
    });
  }

  setStatus(DocumentReference<MovingOrder> ref, OrderStatus status) {
    ref.update({"status": status.name});
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/models/item.dart';

class MovingOrder {
  Timestamp? createdAt;
  List<Item>? items = [];
  final bool? flexibleMovingDate;
  final Timestamp? movingDate;
  final String? destinyAddress;

  MovingOrder({
    this.items,
    this.createdAt,
    this.movingDate,
    this.destinyAddress,
    this.flexibleMovingDate,
  });

  factory MovingOrder.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    final items = List.from(data?['items'])
        .map(
          (e) => Item.fromFirestore(e),
        )
        .toList();

    return MovingOrder(
      items: items,
      createdAt: data?["createdAt"],
      movingDate: data?["movingDate"],
      destinyAddress: data?["destinyAddress"],
      flexibleMovingDate: data?["flexibleMovingDate"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (items != null) "items": items,
      if (createdAt != null) "createdAt": createdAt,
      if (movingDate != null) "movingDate": movingDate,
      if (destinyAddress != null) "destinyAddress": destinyAddress,
      if (flexibleMovingDate != null) "flexibleMovingDate": flexibleMovingDate,
    };
  }
}

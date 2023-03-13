import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muda_facil/src/models/item.dart';

class MovingOrder {
  Timestamp? createdAt;
  List<Item>? items = [];
  bool? flexibleMovingDate;
  Timestamp? movingDate;
  String? destinyAddress;
  String? originAddress;

  MovingOrder({
    this.items,
    this.createdAt,
    this.movingDate,
    this.destinyAddress,
    this.flexibleMovingDate,
    this.originAddress,
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
      originAddress: data?["originAddress"],
      flexibleMovingDate: data?["flexibleMovingDate"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (items != null) "items": items!.map((e) => e.toFirestore()),
      if (createdAt != null) "createdAt": createdAt,
      if (movingDate != null) "movingDate": movingDate,
      if (destinyAddress != null) "destinyAddress": destinyAddress,
      if (originAddress != null) "originAddress": originAddress,
      if (flexibleMovingDate != null) "flexibleMovingDate": flexibleMovingDate,
    };
  }

  @override
  String toString() {
    return "moving order with items: ${items?.map((e) => e.name)}";
  }
}

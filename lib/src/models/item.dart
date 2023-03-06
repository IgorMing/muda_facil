class Item {
  final String name;
  int amount;
  String? comment;

  Item({required this.name, this.amount = 0, this.comment});

  factory Item.fromFirestore(Map<String, dynamic> data) => Item(
        name: data["name"],
        amount: data["amount"],
        comment: data["comment"],
      );
}

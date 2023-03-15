class Item {
  final String name;
  int amount;
  String? comment;

  Item({required this.name, this.amount = 0, this.comment});

  factory Item.fromJson(Map<String, dynamic> data) => Item(
        name: data["name"],
        amount: data["amount"],
        comment: data["comment"],
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "amount": amount,
      if (comment != null) "comment": comment,
    };
  }
}

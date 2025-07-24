class Item {
  final int id;
  final String name;
  final String type;

  Item({required this.id, required this.name, required this.type});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['item_id'],
      name: json['name'],
      type: json['type'],
    );
  }
}

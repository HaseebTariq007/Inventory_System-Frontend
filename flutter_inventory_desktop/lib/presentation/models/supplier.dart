class Supplier {
  final int id;
  final String name;
  final String contactInfo;

  Supplier({required this.id, required this.name, required this.contactInfo});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['supplier_id'],
      name: json['name'],
      contactInfo: json['contact_info'],
    );
  }
}

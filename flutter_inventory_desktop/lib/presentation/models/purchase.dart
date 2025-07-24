class Purchase {
  final int id;
  final int itemId;
  final int supplierId;
  final int quantity;
  final double unitPrice;
  final double totalAmount;
  final String status;
  final String purchaseDate;
  final String? paymentDate;

  Purchase({
    required this.id,
    required this.itemId,
    required this.supplierId,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.status,
    required this.purchaseDate,
    this.paymentDate,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['purchase_id'],
      itemId: json['item_id'],
      supplierId: json['supplier_id'],
      quantity: json['quantity'],
      unitPrice: (json['unit_price'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['payment_status'],
      purchaseDate: json['purchase_date'],
      paymentDate: json['payment_date'],
    );
  }
}

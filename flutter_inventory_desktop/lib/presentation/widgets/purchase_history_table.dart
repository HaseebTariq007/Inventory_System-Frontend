import 'package:flutter/material.dart';

class PurchaseHistoryTable extends StatelessWidget {
  final List<Map<String, dynamic>> purchases;
  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;
  final int currentPage;
  final Function(Map<String, dynamic>)? onEdit;

  const PurchaseHistoryTable({
    Key? key,
    required this.purchases,
    required this.currentPage,
    this.onNextPage,
    this.onPreviousPage,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          color: Colors.grey.shade200,
          child: Row(
            children: const [
              Expanded(
                flex: 2,
                child: Text(
                  'Item Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Qty',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Supplier',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Payment Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Payment Method',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Purchase Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Payment Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Actions',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0, thickness: 1),

        // Purchase list
        Expanded(
          child:
              purchases.isEmpty
                  ? const Center(child: Text('No purchase records found'))
                  : ListView.builder(
                    itemCount: purchases.length,
                    itemBuilder: (context, index) {
                      final purchase = purchases[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 18,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(purchase['item']['name'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(purchase['item']['type'] ?? ''),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('${purchase['quantity'] ?? ''}'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${purchase['total_amount'] ?? ''}',
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    purchase['supplier']['name'] ?? '',
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(purchase['payment_status'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(purchase['payment_method'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(purchase['purchase_date'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(purchase['payment_date'] ?? ''),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        (purchase['payment_status']
                                                    ?.toString()
                                                    .toLowerCase() ==
                                                'unpaid')
                                            ? IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed:
                                                  () => onEdit?.call(purchase),
                                              padding: EdgeInsets.zero,
                                              visualDensity:
                                                  VisualDensity.compact,
                                            )
                                            : const SizedBox.shrink(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 0),
                        ],
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

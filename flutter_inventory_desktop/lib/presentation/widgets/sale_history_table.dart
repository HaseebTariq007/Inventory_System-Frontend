import 'package:flutter/material.dart';

class SaleHistoryTable extends StatelessWidget {
  final List<Map<String, dynamic>> sales;
  final VoidCallback? onNextPage;
  final VoidCallback? onPreviousPage;
  final int currentPage;
  final Function(Map<String, dynamic>)? onEdit;

  const SaleHistoryTable({
    Key? key,
    required this.sales,
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
                  'Customer',
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
                  'Sale Date',
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

        // Sales list
        Expanded(
          child:
              sales.isEmpty
                  ? const Center(child: Text('No sale records found'))
                  : ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      final sale = sales[index];
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
                                  child: Text(sale['item']['name'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(sale['item']['type'] ?? ''),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('${sale['quantity'] ?? ''}'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('${sale['total_amount'] ?? ''}'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(sale['customer']['name'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(sale['payment_status'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(sale['payment_method'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(sale['sale_date'] ?? ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(sale['payment_date'] ?? ''),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        (sale['payment_status']
                                                    ?.toString()
                                                    .toLowerCase() ==
                                                'unpaid')
                                            ? IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed:
                                                  () => onEdit?.call(sale),
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

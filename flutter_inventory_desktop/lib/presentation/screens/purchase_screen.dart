// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../widgets/purchase_form.dart';
// import '../widgets/purchase_history_table.dart';
// import '../widgets/custom_nav_bar.dart';
// import '../state/purchase_provider.dart';

// class PurchaseScreen extends StatelessWidget {
//   const PurchaseScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final purchaseProvider = Provider.of<PurchaseProvider>(context);

//     //Convert List<Purchase> to List<Map<String, dynamic>>
//     final purchases = purchaseProvider.purchases.map((p) => {
//       'item_name': 'Item ${p.itemId}',            // Or fetch actual item name
//       'category': 'Type ${p.itemId}',             // Placeholder category
//       'quantity': p.quantity,
//       'amount': p.unitPrice,
//       'supplier': 'Supplier ${p.supplierId}',     // Or fetch actual supplier name
//       'payment_status': p.status,
//       'payment_method': '',                       // Not available in model
//       'purchase_date': p.purchaseDate,
//       'payment_date': p.paymentDate ?? '',
//       'id': p.id,
//     }).toList();

//     return Scaffold(
//       appBar: const CustomNavBar(title: 'Purchase'),
//       backgroundColor: const Color(0xFFFAF9FB),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 12,
//                   spreadRadius: 2,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Item Purchase',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 PurchaseForm(),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Container(
//                 width: 1350,
//                 margin: const EdgeInsets.symmetric(vertical: 16),
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 10,
//                       spreadRadius: 3,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: PurchaseHistoryTable(
//                   purchases: purchases,
//                   currentPage: purchaseProvider.currentPage,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     DropdownButton<int>(
//                       value: purchaseProvider.limit,
//                       items: const [
//                         DropdownMenuItem(value: 10, child: Text('10')),
//                         DropdownMenuItem(value: 25, child: Text('25')),
//                         DropdownMenuItem(value: 50, child: Text('50')),
//                       ],
//                       onChanged: (int? newValue) {
//                         if (newValue != null) {
//                           purchaseProvider.changeLimit(newValue);
//                         }
//                       },
//                     ),
//                     const SizedBox(width: 20),
//                     ElevatedButton(
//                       onPressed: purchaseProvider.currentPage > 1
//                           ? () => purchaseProvider.previousPage()
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF55221),
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text('Previous'),
//                     ),
//                   ],
//                 ),
//                 Text('Page ${purchaseProvider.currentPage}'),
//                 ElevatedButton(
//                   onPressed: () => purchaseProvider.nextPage(),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF55221),
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Next'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//New code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/purchase_form.dart';
import '../widgets/purchase_history_table.dart';
import '../widgets/custom_nav_bar.dart';
import '../state/purchase_provider.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PurchaseProvider>(context, listen: false).fetchPurchases();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = Provider.of<PurchaseProvider>(context);

    return Scaffold(
      appBar: const CustomNavBar(title: 'Purchase'),
      backgroundColor: const Color(0xFFFAF9FB),
      body: Column(
        children: [
          /// Form Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item Purchase',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                PurchaseForm(),
              ],
            ),
          ),

          /// Table Section
          Expanded(
            child: Center(
              child: Container(
                width: 1350,
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: purchaseProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : purchaseProvider.error != null
                        ? Center(child: Text(purchaseProvider.error!))
                        : PurchaseHistoryTable(
                            purchases: purchaseProvider.purchases,
                            currentPage: purchaseProvider.currentPage,
                          ),
              ),
            ),
          ),

          /// Pagination
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DropdownButton<int>(
                      value: purchaseProvider.limit,
                      items: const [
                        DropdownMenuItem(value: 10, child: Text('10')),
                        DropdownMenuItem(value: 25, child: Text('25')),
                        DropdownMenuItem(value: 50, child: Text('50')),
                      ],
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          purchaseProvider.changeLimit(newValue);
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: purchaseProvider.currentPage > 1
                          ? () => purchaseProvider.previousPage()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF55221),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Previous'),
                    ),
                  ],
                ),
                Text('Page ${purchaseProvider.currentPage}'),
                ElevatedButton(
                  onPressed: () => purchaseProvider.nextPage(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF55221),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

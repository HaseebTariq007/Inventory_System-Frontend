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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../widgets/purchase_form.dart';
// import '../widgets/purchase_history_table.dart';
// import '../widgets/custom_nav_bar.dart';
// import '../state/purchase_provider.dart';

// class PurchaseScreen extends StatefulWidget {
//   const PurchaseScreen({super.key});

//   @override
//   State<PurchaseScreen> createState() => _PurchaseScreenState();
// }

// class _PurchaseScreenState extends State<PurchaseScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<PurchaseProvider>(context, listen: false).fetchPurchases();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final purchaseProvider = Provider.of<PurchaseProvider>(context);

//     return Scaffold(
//       appBar: const CustomNavBar(title: 'Purchase'),
//       backgroundColor: const Color(0xFFFAF9FB),
//       body: Column(
//         children: [
//           /// Form Section
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
//                 SizedBox(height: 5),
//                 PurchaseForm(),
//               ],
//             ),
//           ),

//           /// Table Section
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
//                 child:
//                     purchaseProvider.isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : purchaseProvider.error != null
//                         ? Center(child: Text(purchaseProvider.error!))
//                         : PurchaseHistoryTable(
//                           purchases: purchaseProvider.purchases,
//                           currentPage: purchaseProvider.currentPage,
//                         ),
//               ),
//             ),
//           ),

//           /// Pagination
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
//                       onPressed:
//                           purchaseProvider.currentPage > 1
//                               ? () => purchaseProvider.previousPage()
//                               : null,
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

// New haseeb code

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../widgets/purchase_form.dart';
// import '../widgets/purchase_history_table.dart';
// import '../widgets/custom_nav_bar.dart';
// import '../state/purchase_provider.dart';
// import '../services/api_service.dart';

// class PurchaseScreen extends StatefulWidget {
//   const PurchaseScreen({super.key});

//   @override
//   State<PurchaseScreen> createState() => _PurchaseScreenState();
// }

// class _PurchaseScreenState extends State<PurchaseScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<PurchaseProvider>(context, listen: false).fetchPurchases();
//   }

//   void _showMarkAsPaidDialog(
//     BuildContext context,
//     Map<String, dynamic> purchase,
//   ) {
//     final _formKey = GlobalKey<FormState>();
//     String paymentMethod = 'Cash';
//     String? bankAccount;

//     showDialog(
//       context: context,
//       builder: (ctx) {
//         return AlertDialog(
//           title: const Text('Mark as Paid'),
//           content: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 DropdownButtonFormField<String>(
//                   value: paymentMethod,
//                   items:
//                       ['Cash', 'Bank'].map((method) {
//                         return DropdownMenuItem(
//                           value: method,
//                           child: Text(method),
//                         );
//                       }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       paymentMethod = value!;
//                     });
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Payment Method',
//                   ),
//                 ),
//                 if (paymentMethod == 'Bank')
//                   DropdownButtonFormField<String>(
//                     value: bankAccount,
//                     items:
//                         ['HBL', 'UBL', 'MCB'].map((acc) {
//                           return DropdownMenuItem(value: acc, child: Text(acc));
//                         }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         bankAccount = value;
//                       });
//                     },
//                     decoration: const InputDecoration(
//                       labelText: 'Bank Account',
//                     ),
//                     validator: (value) {
//                       if (paymentMethod == 'Bank' &&
//                           (value == null || value.isEmpty)) {
//                         return 'Please select a bank account';
//                       }
//                       return null;
//                     },
//                   ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(ctx).pop(),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   try {
//                     await ApiService.updatePurchase(
//                       int.parse(purchase['id'].toString()),
//                       {
//                         'payment_status': 'PAID',
//                         'payment_method': paymentMethod,
//                         'bank_account':
//                             paymentMethod == 'Bank' ? bankAccount : null,
//                       },
//                     );
//                     Navigator.of(ctx).pop();
//                     Provider.of<PurchaseProvider>(
//                       context,
//                       listen: false,
//                     ).fetchPurchases();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Purchase marked as Paid')),
//                     );
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Failed to update: $e')),
//                     );
//                   }
//                 }
//               },
//               child: const Text('Mark as Paid'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final purchaseProvider = Provider.of<PurchaseProvider>(context);

//     return Scaffold(
//       appBar: const CustomNavBar(title: 'Purchase'),
//       backgroundColor: const Color(0xFFFAF9FB),
//       body: Column(
//         children: [
//           /// Form Section
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
//                 SizedBox(height: 5),
//                 PurchaseForm(),
//               ],
//             ),
//           ),

//           /// Table Section
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
//                 child:
//                     purchaseProvider.isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : purchaseProvider.error != null
//                         ? Center(child: Text(purchaseProvider.error!))
//                         : PurchaseHistoryTable(
//                           purchases: purchaseProvider.purchases,
//                           currentPage: purchaseProvider.currentPage,
//                           onEdit:
//                               (purchase) =>
//                                   _showMarkAsPaidDialog(context, purchase),
//                         ),
//               ),
//             ),
//           ),

//           /// Pagination
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
//                       onPressed:
//                           purchaseProvider.currentPage > 1
//                               ? () => purchaseProvider.previousPage()
//                               : null,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/purchase_form.dart';
import '../widgets/purchase_history_table.dart';
import '../widgets/custom_nav_bar.dart';
import '../state/purchase_provider.dart';
import '../services/api_service.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  String _selectedPaymentMethod = 'CASH';
  String? _selectedBankAccount;

  void _showMarkAsPaidDialog(
    BuildContext context,
    Map<String, dynamic> purchase,
  ) {
    _selectedPaymentMethod = 'CASH';
    _selectedBankAccount = null;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Mark Purchase as Paid'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedPaymentMethod,
                      items: const [
                        DropdownMenuItem(value: 'CASH', child: Text('Cash')),
                        DropdownMenuItem(value: 'BANK', child: Text('Bank')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                          if (_selectedPaymentMethod == 'CASH')
                            _selectedBankAccount = null;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Payment Method',
                      ),
                    ),
                    if (_selectedPaymentMethod == 'BANK')
                      DropdownButtonFormField<String>(
                        value: _selectedBankAccount,
                        items: const [
                          DropdownMenuItem(value: 'HBL', child: Text('HBL')),
                          DropdownMenuItem(value: 'UBL', child: Text('UBL')),
                          DropdownMenuItem(value: 'MCB', child: Text('MCB')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedBankAccount = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Bank Account',
                        ),
                      ),
                  ],
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ApiService.updatePurchase(
                      purchase['purchase_id'].toString(),
                      {
                        'payment_status': 'PAID',
                        'payment_method': _selectedPaymentMethod,
                        if (_selectedPaymentMethod == 'BANK')
                          'bank_account': _selectedBankAccount,
                      },
                    );

                    // Refresh purchase list
                    Provider.of<PurchaseProvider>(
                      context,
                      listen: false,
                    ).fetchPurchases();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update: $e')),
                    );
                  }
                },
                child: const Text('Mark as Paid'),
              ),
            ],
          ),
    );
  }

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
                const Text(
                  'Item Purchase',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
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
                child:
                    purchaseProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : purchaseProvider.error != null
                        ? Center(child: Text(purchaseProvider.error!))
                        : PurchaseHistoryTable(
                          purchases: purchaseProvider.purchases,
                          currentPage: purchaseProvider.currentPage,
                          onEdit:
                              (purchase) =>
                                  _showMarkAsPaidDialog(context, purchase),
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
                      onPressed:
                          purchaseProvider.currentPage > 1
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

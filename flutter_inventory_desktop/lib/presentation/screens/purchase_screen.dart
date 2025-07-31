// New code with next pagination disabled applied

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
  final TextEditingController _searchController = TextEditingController();

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
                  onPressed:
                      purchaseProvider.currentPage < purchaseProvider.totalPages
                          ? () => purchaseProvider.nextPage()
                          : null,
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

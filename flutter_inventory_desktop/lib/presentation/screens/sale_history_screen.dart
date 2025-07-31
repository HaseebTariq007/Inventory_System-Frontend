// next button disable logic

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sale_filter_ui.dart';
import '../widgets/sale_history_table.dart';
import '../widgets/custom_nav_bar.dart';
import '../state/sale_history_provider.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  String _selectedPaymentMethod = 'CASH';
  String? _selectedBankAccount;
  final TextEditingController _searchController = TextEditingController();

  void _showMarkAsPaidDialog(BuildContext context, Map<String, dynamic> sale) {
    _selectedPaymentMethod = 'CASH';
    _selectedBankAccount = null;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Mark Sale as Paid'),
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
                    final provider = Provider.of<SaleProvider>(
                      context,
                      listen: false,
                    );
                    await provider.updateSaleStatus(
                      sale['sale_id'].toString(),
                      _selectedPaymentMethod,
                      bankAccount:
                          _selectedPaymentMethod == 'BANK'
                              ? _selectedBankAccount
                              : null,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sale status updated successfully'),
                      ),
                    );
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SaleProvider>(context, listen: false);
      provider.refreshSales();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saleProvider = Provider.of<SaleProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        final provider = Provider.of<SaleProvider>(context, listen: false);
        await provider.refreshSales();
        return true;
      },
      child: Scaffold(
        appBar: const CustomNavBar(title: 'Sale'),
        backgroundColor: const Color(0xFFFAF9FB),
        body: Column(
          children: [
            SaleFilterUI(),
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
                      saleProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : saleProvider.error != null
                          ? Center(child: Text(saleProvider.error!))
                          : Consumer<SaleProvider>(
                            builder: (context, provider, child) {
                              return SaleHistoryTable(
                                sales: provider.sales,
                                currentPage: provider.currentPage,
                                onEdit:
                                    (sale) =>
                                        _showMarkAsPaidDialog(context, sale),
                              );
                            },
                          ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      DropdownButton<int>(
                        value: saleProvider.limit,
                        items: const [
                          DropdownMenuItem(value: 10, child: Text('10')),
                          DropdownMenuItem(value: 25, child: Text('25')),
                          DropdownMenuItem(value: 50, child: Text('50')),
                        ],
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            saleProvider.changeLimit(newValue);
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed:
                            saleProvider.currentPage > 1
                                ? () => saleProvider.previousPage()
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF55221),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Previous'),
                      ),
                    ],
                  ),
                  Text('Page ${saleProvider.currentPage}'),
                  ElevatedButton(
                    onPressed:
                        saleProvider.currentPage < saleProvider.totalPages
                            ? () => saleProvider.nextPage()
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
      ),
    );
  }
}

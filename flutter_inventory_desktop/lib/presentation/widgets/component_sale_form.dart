// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../state/component_sale_provider.dart';

class ComponentSaleForm extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onSaleCreated;

  const ComponentSaleForm({super.key, this.onSaleCreated});

  @override
  _ComponentSaleFormState createState() => _ComponentSaleFormState();
}

class _ComponentSaleFormState extends State<ComponentSaleForm> {
  String? selectedItem;
  String? selectedType;
  String? selectedCustomer;
  String paymentStatus = 'UNPAID';
  String? paymentMethod;
  String? selectedBankAccount;

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController newBankAccountController =
      TextEditingController();

  List<String> items = [];
  Map<String, List<String>> types = {};
  Map<String, int> itemNameToId = {};
  Map<String, Map<String, int>> itemTypeToId = {};
  Map<String, String> customerIdToName =
      {}; // key: customer_id, value: customer name
  List<String> customers = [];
  Map<String, String> customerNameToId = {};
  List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
    _loadBankAccounts();
  }

  Future<void> _loadDropdownData() async {
    try {
      final [itemList, customerList] = await Future.wait([
        ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
        ApiService.fetchCustomers(),
      ]);

      final itemSet = <String>{};
      final itemTypeMap = <String, List<String>>{};
      final itemIdMap = <String, int>{};
      final itemTypeIdMap = <String, Map<String, int>>{};

      for (var item in itemList) {
        final itemName = item['name'];
        final type = item['type'];
        final id = item['item_id'] ?? item['id'];

        itemSet.add(itemName);
        itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
        itemIdMap[itemName] = id.hashCode;
        itemTypeIdMap[itemName] = {
          ...?itemTypeIdMap[itemName],
          type: id.hashCode,
        };
      }

      final customerNames = <String>[];
      final customerIds = <String, String>{};
      for (var c in customerList) {
        customerNames.add(c['name']);
        customerIds[c['name']] = c['customer_id'];
        customerIdToName[c['customer_id']] = c['name']; //Add this
      }

      setState(() {
        items = itemSet.toList();
        types = itemTypeMap;
        itemNameToId = itemIdMap;
        itemTypeToId = itemTypeIdMap;
        customers = customerNames;
        customerNameToId = customerIds;
      });
    } catch (e) {
      setState(() {
        customers = [];
        customerNameToId = {};
      });
    }
  }

  Future<void> _loadBankAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAccounts = prefs.getStringList('bankAccounts');
    if (savedAccounts != null && savedAccounts.isNotEmpty) {
      setState(() {
        bankAccounts = savedAccounts;
      });
    }
  }

  Future<void> _saveBankAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bankAccounts', bankAccounts);
  }

  void _showAddBankAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Bank Account'),
          content: TextField(
            controller: newBankAccountController,
            decoration: const InputDecoration(
              hintText: 'Enter new bank name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (newBankAccountController.text.isNotEmpty &&
                    !bankAccounts.contains(newBankAccountController.text)) {
                  setState(() {
                    bankAccounts.add(newBankAccountController.text);
                    selectedBankAccount = newBankAccountController.text;
                    newBankAccountController.clear();
                  });
                  await _saveBankAccounts();
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
  }) {
    return SizedBox(
      width: 150,
      height: 36,
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?)? onChanged,
  }) {
    return SizedBox(
      width: 150,
      height: 36,
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items:
            items
                .map(
                  (item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(item.toString()),
                  ),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPaymentStatusButtons() {
    return SizedBox(
      width: 160,
      height: 36,
      child: Row(
        children:
            ['PAID', 'UNPAID'].map((label) {
              final isActive = paymentStatus == label;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: ElevatedButton(
                    onPressed:
                        () => setState(() {
                          paymentStatus = label;
                          if (paymentStatus == 'PAID') {
                            paymentMethod = null;
                            selectedBankAccount = null;
                          }
                        }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isActive ? const Color(0xFFF55221) : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(label),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildSaleButton() {
    return SizedBox(
      width: 110,
      height: 36,
      child: ElevatedButton(
        onPressed: _submitSale,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Sale'),
      ),
    );
  }

  Future<void> _submitSale() async {
    if (selectedItem == null ||
        selectedType == null ||
        selectedCustomer == null ||
        quantityController.text.isEmpty ||
        amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (paymentStatus == 'PAID' &&
        (paymentMethod == null ||
            (paymentMethod == 'BANK' && selectedBankAccount == null))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select a payment method and bank account if applicable",
          ),
        ),
      );
      return;
    }

    final quantity = int.tryParse(quantityController.text) ?? 0;
    final amount = double.tryParse(amountController.text) ?? 0.0;
    final total = quantity * amount;

    final itemId = itemTypeToId[selectedItem]?[selectedType];
    final customerId = customerNameToId[selectedCustomer!];

    final saleData = {
      'item_id': itemId,
      'item_name': selectedItem,
      'item_type': selectedType,
      'customer_id': customerId,
      'customer_name': customerIdToName[customerId],
      'quantity': quantity,
      'total_amount': total,
      'payment_status': paymentStatus,
      'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
      if (paymentMethod == 'BANK' && selectedBankAccount != null)
        'bank_account': selectedBankAccount,
    };

    try {
      await Provider.of<ComponentSaleProvider>(
        context,
        listen: false,
      ).createSale(saleData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sale created successfully")),
      );
      widget.onSaleCreated?.call(saleData);

      await _loadDropdownData();
      _resetFormFields();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error creating sale")));
    }
  }

  void _resetFormFields() {
    setState(() {
      selectedItem = null;
      selectedType = null;
      selectedCustomer = null;
      paymentStatus = 'UNPAID';
      paymentMethod = null;
      selectedBankAccount = null;
      quantityController.clear();
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _buildDropdown<String>(
          label: 'Select Item',
          value: selectedItem,
          items: items,
          onChanged: (val) {
            setState(() {
              selectedItem = val;
              selectedType = null;
            });
          },
        ),
        if (selectedItem != null)
          _buildDropdown<String>(
            label: 'Select Type',
            value: selectedType,
            items: types[selectedItem] ?? [],
            onChanged: (val) => setState(() => selectedType = val),
          ),
        _buildInputField(quantityController, 'Qty', isNumber: true),
        _buildInputField(amountController, 'Amount', isNumber: true),
        _buildDropdown<String>(
          label: 'Customer',
          value: selectedCustomer,
          items: customers,
          onChanged: (val) => setState(() => selectedCustomer = val),
        ),
        _buildPaymentStatusButtons(),
        if (paymentStatus == 'PAID')
          _buildDropdown<String>(
            label: 'Payment Method',
            value: paymentMethod,
            items: ['CASH', 'BANK'],
            onChanged: (val) {
              setState(() {
                paymentMethod = val;
                if (val != 'BANK') selectedBankAccount = null;
              });
            },
          ),
        if (paymentStatus == 'PAID' && paymentMethod == 'BANK')
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDropdown<String>(
                label: 'Select Bank Account',
                value: selectedBankAccount,
                items: bankAccounts,
                onChanged: (val) => setState(() => selectedBankAccount = val),
              ),
              const SizedBox(width: 4),
              SizedBox(
                height: 36,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddBankAccountDialog(context),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        _buildSaleButton(),
      ],
    );
  }
}

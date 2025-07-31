import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'package:provider/provider.dart';
import '../state/purchase_provider.dart';

class PurchaseForm extends StatefulWidget {
  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  bool isNewItem = false;
  bool showSearchDropdown = false;
  bool showSearchOptions = false;
  bool showSearchField = false;
  String? selectedItem;
  String? selectedType;
  String? selectedSupplier;
  String paymentStatus = 'UNPAID';
  String? paymentMethod;
  String? selectedBankAccount;
  String selectedSearchOption = 'item';
  String? selectedDropdownValue;

  String? selectedFilter;
  String? selectedFilterValue;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController newItemNameController = TextEditingController();
  final TextEditingController newItemTypeController = TextEditingController();
  final TextEditingController newBankAccountController =
      TextEditingController();
  final TextEditingController _purchaseDateController = TextEditingController();

  List<String> items = [];
  Map<String, List<String>> types = {};
  Map<String, int> itemNameToId = {};
  Map<String, Map<String, int>> itemTypeToId = {};
  List<String> suppliers = [];
  Map<String, String> supplierNameToId = {};
  List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
    _loadBankAccounts();
  }

  @override
  void dispose() {
    _purchaseDateController.dispose();
    super.dispose();
  }

  Future<void> _loadDropdownData() async {
    try {
      final [itemList, supplierList] = await Future.wait([
        ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
        ApiService.fetchSuppliers(),
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

      final supplierNames = <String>[];
      final supplierIds = <String, String>{};
      for (var s in supplierList) {
        supplierNames.add(s['name']);
        supplierIds[s['name']] = s['supplier_id'];
      }

      setState(() {
        items = itemSet.toList();
        types = itemTypeMap;
        itemNameToId = itemIdMap;
        itemTypeToId = itemTypeIdMap;
        suppliers = supplierNames;
        supplierNameToId = supplierIds;
      });
    } catch (e) {
      setState(() {
        suppliers = [];
        supplierNameToId = {};
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (isNewItem) ...[
                  _buildInputField(newItemNameController, 'Item Name'),
                  _buildInputField(newItemTypeController, 'Category'),
                ] else ...[
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
                ],
                _buildInputField(quantityController, 'Qty', isNumber: true),
                _buildInputField(amountController, 'Amount', isNumber: true),
                _buildDropdown<String>(
                  label: 'Supplier',
                  value: selectedSupplier,
                  items: suppliers,
                  onChanged: (val) => setState(() => selectedSupplier = val),
                ),
                _buildPaymentStatusButtons(),
                if (paymentStatus == 'PAID')
                  _buildDropdown<String>(
                    label: 'Payment Method',
                    value: paymentMethod,
                    items: ['CASH', 'BANK'],
                    onChanged:
                        (val) => setState(() {
                          paymentMethod = val;
                          if (val != 'BANK') {
                            selectedBankAccount = null;
                          }
                        }),
                  ),
                if (paymentStatus == 'PAID' && paymentMethod == 'BANK')
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 150,
                        child: _buildDropdown<String>(
                          label: 'Select Bank Acc..',
                          value: selectedBankAccount,
                          items: bankAccounts,
                          onChanged:
                              (val) =>
                                  setState(() => selectedBankAccount = val),
                        ),
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
                _buildPurchaseButton(),
                _buildNewItemButton(),
              ],
            ),
            const SizedBox(height: 12),
            _buildFilterUI(),
          ],
        ),
      ),
    );
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

  Widget _buildFilterUI() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          PopupMenuButton<String>(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: const [
                  Icon(Icons.filter_list),
                  SizedBox(width: 6),
                  Text('Filter', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            onSelected: (value) {
              setState(() {
                selectedSearchOption = value;
                _searchController.clear();
                _purchaseDateController.clear();
                selectedDropdownValue = null;
                showSearchField = true;
              });
            },
            itemBuilder:
                (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'item',
                    child: Text('Search by Item Name'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'supplier',
                    child: Text('Search by Supplier Name'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'payment_status',
                    child: Text('Payment Status'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'purchase_date',
                    child: Text('Purchase Date'),
                  ),
                ],
          ),

          const SizedBox(width: 12),

          if (showSearchField &&
              (selectedSearchOption == 'item' ||
                  selectedSearchOption == 'supplier'))
            SizedBox(
              width: 160,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText:
                      selectedSearchOption == 'item'
                          ? 'Search by Item Name'
                          : 'Search by Supplier Name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final provider = Provider.of<PurchaseProvider>(
                        context,
                        listen: false,
                      );
                      if (selectedSearchOption == 'item') {
                        provider.applySearch(
                          _searchController.text,
                          searchType: 'item',
                        );
                      } else if (selectedSearchOption == 'supplier') {
                        provider.applySearch(
                          _searchController.text,
                          searchType: 'supplier',
                        );
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSubmitted: (value) {
                  final provider = Provider.of<PurchaseProvider>(
                    context,
                    listen: false,
                  );
                  if (selectedSearchOption == 'item') {
                    provider.applySearch(value, searchType: 'item');
                  } else if (selectedSearchOption == 'supplier') {
                    provider.applySearch(value, searchType: 'supplier');
                  }
                },
              ),
            ),

          if (selectedSearchOption == 'payment_status')
            DropdownButton<String>(
              hint: const Text('Select Payment Status'),
              value: selectedDropdownValue,
              items: const [
                DropdownMenuItem(value: 'Paid', child: Text('Paid')),
                DropdownMenuItem(value: 'Unpaid', child: Text('Unpaid')),
              ],
              onChanged: (value) {
                setState(() => selectedDropdownValue = value);
                Provider.of<PurchaseProvider>(
                  context,
                  listen: false,
                ).applySearch(value!, searchType: 'payment_status');
              },
            ),

          if (selectedSearchOption == 'purchase_date') ...[
            SizedBox(
              width: 160,
              child: TextField(
                controller: _purchaseDateController,
                decoration: InputDecoration(
                  labelText: 'Enter Purchase Date',
                  hintText: 'YY:MM:DD',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final value = _purchaseDateController.text;
                      Provider.of<PurchaseProvider>(
                        context,
                        listen: false,
                      ).applySearch(value, searchType: 'purchase_date');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSubmitted: (value) {
                  Provider.of<PurchaseProvider>(
                    context,
                    listen: false,
                  ).applySearch(value, searchType: 'purchase_date');
                },
              ),
            ),
            const SizedBox(width: 12),
          ],

          if (selectedSearchOption != 'item' ||
              selectedDropdownValue != null ||
              _searchController.text.isNotEmpty ||
              _purchaseDateController.text.isNotEmpty)
            const SizedBox(width: 24),
          ElevatedButton.icon(
            onPressed: () {
              _searchController.clear();
              _purchaseDateController.clear();
              selectedDropdownValue = null;

              Provider.of<PurchaseProvider>(
                context,
                listen: false,
              ).clearSearch();

              setState(() {
                showSearchField = false;
                selectedSearchOption = 'item';
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF66032),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label.isNotEmpty ? label : null,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
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
      child: PopupMenuButton<T>(
        color: Colors.white,
        child: InputDecorator(
          decoration: _dropdownDecoration(label),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value?.toString() ?? label,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
        ),
        onSelected: (val) {
          onChanged?.call(val);
          setState(() {
            if (val is String) {
              if (label == 'Payment Method' && val != 'BANK') {
                selectedBankAccount = null;
              }
            }
          });
        },
        itemBuilder:
            (BuildContext context) =>
                items
                    .map(
                      (item) => PopupMenuItem<T>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
        offset: const Offset(
          0,
          40,
        ), // Adjusted to ensure dropdown appears below
        constraints: const BoxConstraints(
          maxHeight: 200,
        ), // Limit dropdown height with scrolling
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

  Widget _buildPurchaseButton() {
    return SizedBox(
      width: 110,
      height: 36,
      child: ElevatedButton(
        onPressed: _submitPurchase,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Purchase'),
      ),
    );
  }

  Widget _buildNewItemButton() {
    return SizedBox(
      width: 110,
      height: 36,
      child: ElevatedButton(
        onPressed: () => setState(() => isNewItem = !isNewItem),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF55221),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isNewItem) const Icon(Icons.add, size: 16),
            if (!isNewItem) const SizedBox(width: 4),
            Text(isNewItem ? 'Cancel' : 'New Item'),
          ],
        ),
      ),
    );
  }

  Future<void> _submitPurchase() async {
    if ((isNewItem &&
            (newItemNameController.text.isEmpty ||
                newItemTypeController.text.isEmpty)) ||
        (!isNewItem && (selectedItem == null || selectedType == null)) ||
        selectedSupplier == null ||
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

    final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];
    final supplierId = supplierNameToId[selectedSupplier!];

    final purchaseData = {
      'item_id': itemId,
      'item_name': isNewItem ? newItemNameController.text : selectedItem,
      'item_type': isNewItem ? newItemTypeController.text : selectedType,
      'supplier_id': supplierId,
      'quantity': quantity,
      'unit_price': amount,
      'total_amount': total,
      'payment_status': paymentStatus,
      'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
      if (paymentMethod == 'BANK' && selectedBankAccount != null)
        'bank_account': selectedBankAccount,
      'purchase_date': DateTime.now().toIso8601String(),
    };

    try {
      await ApiService.submitPurchase(purchaseData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Purchase created successfully")),
      );
      await _loadDropdownData();
      _resetFormFields();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
    }
  }

  void _resetFormFields() {
    setState(() {
      isNewItem = false;
      selectedItem = null;
      selectedType = null;
      selectedSupplier = null;
      paymentStatus = 'UNPAID';
      paymentMethod = null;
      selectedBankAccount = null;
      quantityController.clear();
      amountController.clear();
      newItemNameController.clear();
      newItemTypeController.clear();
    });
  }
}

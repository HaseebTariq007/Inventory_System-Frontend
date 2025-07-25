// import 'package:flutter/material.dart';
// import '../services/api_service.dart';

// class PurchaseForm extends StatefulWidget {
//   @override
//   _PurchaseFormState createState() => _PurchaseFormState();
// }

// class _PurchaseFormState extends State<PurchaseForm> {
//   bool isNewItem = false;
//   String? selectedItem;
//   String? selectedType;
//   String? selectedSupplier;
//   String paymentStatus = 'Unpaid';
//   String? paymentMethod;

//   // New filter dropdowns
//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();

//   List<String> items = ['Inverter-body', 'Solar Panel'];
//   Map<String, List<String>> types = {
//     'Inverter-body': ['18KW', '20KW'],
//     'Solar Panel': ['100W', '200W']
//   };
//   List<String> suppliers = ['Waleed', 'Kashif'];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Form Fields
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Type'),
//             ] else ...[
//               _buildDropdown<String>(
//                 label: 'Select Item',
//                 value: selectedItem,
//                 items: items,
//                 onChanged: (val) {
//                   setState(() {
//                     selectedItem = val;
//                     selectedType = null;
//                   });
//                 },
//               ),
//               if (selectedItem != null)
//                 _buildDropdown<String>(
//                   label: 'Select Type',
//                   value: selectedType,
//                   items: types[selectedItem]!,
//                   onChanged: (val) => setState(() => selectedType = val),
//                 ),
//             ],
//             _buildInputField(quantityController, 'Qty', isNumber: true),
//             _buildInputField(amountController, 'Amount', isNumber: true),
//             _buildDropdown<String>(
//               label: 'Supplier',
//               value: selectedSupplier,
//               items: suppliers,
//               onChanged: (val) => setState(() => selectedSupplier = val),
//             ),
//             _buildPaymentStatusButtons(),
//             _buildDropdown<String>(
//               label: 'Payment Method',
//               value: paymentMethod,
//               items: ['Cash in Hand', 'Bank'],
//               onChanged: paymentStatus == 'Paid'
//                   ? (val) => setState(() => paymentMethod = val)
//                   : null,
//             ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),

//         const SizedBox(height: 20),

//         /// FILTER UI LIKE STOCK LIST
//         Container(
//           padding: const EdgeInsets.all(10),
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               /// Filter by Item Name
//               SizedBox(
//                 width: 180,
//                 child: DropdownButtonFormField<String>(
//                   value: selectedFilter,
//                   hint: const Text('Select Item'),
//                   decoration: _dropdownDecoration(''),
//                   items: items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedFilter = value;
//                       selectedFilterValue = null;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(width: 10),

//               /// Filter by Type
//               if (selectedFilter != null)
//                 SizedBox(
//                   width: 180,
//                   child: DropdownButtonFormField<String>(
//                     value: selectedFilterValue,
//                     hint: const Text('Select Type'),
//                     decoration: _dropdownDecoration(''),
//                     items: types[selectedFilter]!.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedFilterValue = value;
//                       });
//                     },
//                   ),
//                 ),
//               const SizedBox(width: 12),
//               const Icon(Icons.filter_list),
//               const SizedBox(width: 4),
//               const Text('Filter'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label.isNotEmpty ? label : null,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   Widget _buildInputField(TextEditingController controller, String label,
//       {bool isNumber = false}) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           fillColor: Colors.grey.shade100,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown<T>({
//     required String label,
//     required T? value,
//     required List<T> items,
//     required void Function(T?)? onChanged,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: DropdownButtonFormField<T>(
//         value: value,
//         isExpanded: true,
//         decoration: InputDecoration(
//           labelText: label.isNotEmpty ? label : null,
//           filled: true,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           fillColor: Colors.grey.shade100,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         items: items
//             .map((item) => DropdownMenuItem<T>(
//                   value: item,
//                   child: Text(item.toString()),
//                 ))
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children: ['Paid', 'Unpaid'].map((label) {
//           final isActive = paymentStatus == label;
//           return Expanded(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               child: ElevatedButton(
//                 onPressed: () => setState(() => paymentStatus = label),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       isActive ? const Color(0xFFF55221) : Colors.grey,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(label),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildPurchaseButton() {
//     return SizedBox(
//       width: 120,
//       height: 40,
//       child: ElevatedButton(
//         onPressed: _submitPurchase,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue[900],
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: const Text('Purchase'),
//       ),
//     );
//   }

//   Widget _buildNewItemButton() {
//     return SizedBox(
//       height: 40,
//       child: ElevatedButton(
//         onPressed: () => setState(() => isNewItem = !isNewItem),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF55221),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem)
//               const Icon(Icons.add, color: Colors.white, size: 18),
//             if (!isNewItem) const SizedBox(width: 6),
//             Text(isNewItem ? 'Cancel' : 'New Item'),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _submitPurchase() async {
//     if ((isNewItem &&
//             (newItemNameController.text.isEmpty ||
//                 newItemTypeController.text.isEmpty)) ||
//         (!isNewItem && (selectedItem == null || selectedType == null)) ||
//         selectedSupplier == null ||
//         quantityController.text.isEmpty ||
//         amountController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all fields")),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final purchaseData = {
//       'item_id': 1,
//       'supplier_id': 1,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'purchase_date': DateTime.now().toIso8601String(),
//       'payment_date':
//           paymentStatus == 'Paid' ? DateTime.now().toIso8601String() : null,
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Error creating purchase")),
//       );
//     }
//   }
// }

//New Code

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class PurchaseForm extends StatefulWidget {
  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  bool isNewItem = false;
  String? selectedItem;
  String? selectedType;
  String? selectedSupplier;
  String paymentStatus = 'Unpaid';
  String? paymentMethod;

  String? selectedFilter;
  String? selectedFilterValue;

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController newItemNameController = TextEditingController();
  final TextEditingController newItemTypeController = TextEditingController();

  List<String> items = [];
  Map<String, List<String>> types = {};
  Map<String, int> itemNameToId = {};
  Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id

  List<String> suppliers = [];
  Map<String, int> supplierNameToId = {};

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    try {
      final itemList = await ApiService.fetchItems(); // [{name, type, id}]
      final supplierList = await ApiService.fetchSuppliers(); // [{name, id}]

      final itemSet = <String>{};
      final itemTypeMap = <String, List<String>>{};
      final itemIdMap = <String, int>{};
      final itemTypeIdMap = <String, Map<String, int>>{};

      for (var item in itemList) {
        final itemName = item['name'];
        final type = item['type'];
        final id = item['id'];

        itemSet.add(itemName);
        itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
        itemIdMap[itemName] = id;
        itemTypeIdMap[itemName] = {
          ...?itemTypeIdMap[itemName],
          type: id,
        };
      }

      final supplierNames = <String>[];
      final supplierIds = <String, int>{};
      for (var s in supplierList) {
        supplierNames.add(s['name']);
        supplierIds[s['name']] = s['id'];
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
      print("Failed loading dropdown data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (isNewItem) ...[
              _buildInputField(newItemNameController, 'Item Name'),
              _buildInputField(newItemTypeController, 'Type'),
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
            _buildDropdown<String>(
              label: 'Payment Method',
              value: paymentMethod,
              items: ['Cash', 'Bank'],
              onChanged: paymentStatus == 'Paid'
                  ? (val) => setState(() => paymentMethod = val)
                  : null,
            ),
            _buildPurchaseButton(),
            _buildNewItemButton(),
          ],
        ),
        const SizedBox(height: 20),
        _buildFilterUI(),
      ],
    );
  }

  Widget _buildFilterUI() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
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
          SizedBox(
            width: 180,
            child: DropdownButtonFormField<String>(
              value: selectedFilter,
              hint: const Text('Select Item'),
              decoration: _dropdownDecoration(''),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value;
                  selectedFilterValue = null;
                });
              },
            ),
          ),
          const SizedBox(width: 10),
          if (selectedFilter != null)
            SizedBox(
              width: 180,
              child: DropdownButtonFormField<String>(
                value: selectedFilterValue,
                hint: const Text('Select Type'),
                decoration: _dropdownDecoration(''),
                items: types[selectedFilter]?.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList() ??
                    [],
                onChanged: (value) {
                  setState(() => selectedFilterValue = value);
                },
              ),
            ),
          const SizedBox(width: 12),
          const Icon(Icons.filter_list),
          const SizedBox(width: 4),
          const Text('Filter'),
        ],
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label.isNotEmpty ? label : null,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, {bool isNumber = false}) {
    return SizedBox(
      width: 160,
      height: 40,
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
      width: 160,
      height: 40,
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: true,
        decoration: _dropdownDecoration(label),
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.toString()),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPaymentStatusButtons() {
    return SizedBox(
      width: 170,
      height: 40,
      child: Row(
        children: ['Paid', 'Unpaid'].map((label) {
          final isActive = paymentStatus == label;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                onPressed: () => setState(() => paymentStatus = label),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? const Color(0xFFF55221) : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
      width: 120,
      height: 40,
      child: ElevatedButton(
        onPressed: _submitPurchase,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Purchase'),
      ),
    );
  }

  Widget _buildNewItemButton() {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => setState(() => isNewItem = !isNewItem),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF55221),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isNewItem) const Icon(Icons.add, size: 18),
            if (!isNewItem) const SizedBox(width: 6),
            Text(isNewItem ? 'Cancel' : 'New Item'),
          ],
        ),
      ),
    );
  }

  Future<void> _submitPurchase() async {
    if ((isNewItem &&
            (newItemNameController.text.isEmpty || newItemTypeController.text.isEmpty)) ||
        (!isNewItem && (selectedItem == null || selectedType == null)) ||
        selectedSupplier == null ||
        quantityController.text.isEmpty ||
        amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final quantity = int.tryParse(quantityController.text) ?? 0;
    final amount = double.tryParse(amountController.text) ?? 0.0;
    final total = quantity * amount;

    final itemId = isNewItem
        ? null
        : itemTypeToId[selectedItem]?[selectedType];

    final supplierId = supplierNameToId[selectedSupplier!];

    final purchaseData = {
      'item_id': itemId,
      'supplier_id': supplierId,
      'quantity': quantity,
      'unit_price': amount,
      'total_amount': total,
      'payment_status': paymentStatus,
      'method': paymentStatus == 'Paid' ? paymentMethod : null,
      'bank_account': paymentMethod == 'Bank' ? "Meezan" : null,
      'purchase_date': DateTime.now().toIso8601String(),
    };

    try {
      await ApiService.submitPurchase(purchaseData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Purchase created successfully")),
      );
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error creating purchase")),
      );
    }
  }
}


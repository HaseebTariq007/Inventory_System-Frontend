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
//   String paymentStatus = 'UnPAID';
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
//               onChanged: paymentStatus == 'PAID'
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
//         children: ['PAID', 'UnPAID'].map((label) {
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
//           paymentStatus == 'PAID' ? DateTime.now().toIso8601String() : null,
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
//   String paymentStatus = 'UnPAID';
//   String? paymentMethod;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id

//   List<String> suppliers = [];
//   Map<String, int> supplierNameToId = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final itemList = await ApiService.fetchItems(); // [{name, type, id}]
//       final supplierList = await ApiService.fetchSuppliers(); // [{name, id}]

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {
//           ...?itemTypeIdMap[itemName],
//           type: id,
//         };
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, int>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
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
//                   items: types[selectedItem] ?? [],
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
//               items: ['Cash', 'Bank'],
//               onChanged: paymentStatus == 'PAID'
//                   ? (val) => setState(() => paymentMethod = val)
//                   : null,
//             ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items: items.map((item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items: types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(TextEditingController controller, String label, {bool isNumber = false}) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
//         decoration: _dropdownDecoration(label),
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
//         children: ['PAID', 'UnPAID'].map((label) {
//           final isActive = paymentStatus == label;
//           return Expanded(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               child: ElevatedButton(
//                 onPressed: () => setState(() => paymentStatus = label),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isActive ? const Color(0xFFF55221) : Colors.grey,
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
//             if (!isNewItem) const Icon(Icons.add, size: 18),
//             if (!isNewItem) const SizedBox(width: 6),
//             Text(isNewItem ? 'Cancel' : 'New Item'),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _submitPurchase() async {
//     if ((isNewItem &&
//             (newItemNameController.text.isEmpty || newItemTypeController.text.isEmpty)) ||
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

//     final itemId = isNewItem
//         ? null
//         : itemTypeToId[selectedItem]?[selectedType];

//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'method': paymentStatus == 'PAID' ? paymentMethod : null,
//       'bank_account': paymentMethod == 'Bank' ? "Meezan" : null,
//       'purchase_date': DateTime.now().toIso8601String(),
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
//   String paymentStatus = 'UnPAID';
//   String? paymentMethod;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id

//   List<String> suppliers = [];
//   Map<String, int> supplierNameToId = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       // Fetch items and suppliers concurrently for better performance
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems(), // [{name, type, id}]
//         ApiService.fetchSuppliers(), // [{name, id}]
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       // Ensure suppliers are populated even if items fail
//       final supplierNames = <String>[];
//       final supplierIds = <String, int>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames; // Always update suppliers
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       // Set empty suppliers as fallback to ensure dropdown renders
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Type'),
//             ] else if (items.isNotEmpty) ...[
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['Cash', 'Bank'],
//                 onChanged: (val) => setState(() => paymentMethod = val),
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 10,
//           ),
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
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children:
//             ['PAID', 'UnPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];

//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'method': paymentStatus == 'PAID' ? paymentMethod : null,
//       'bank_account': paymentMethod == 'Bank' ? "Meezan" : null,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

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
//   String paymentStatus = 'UnPAID';
//   String? paymentMethod;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id

//   List<String> suppliers = [];
//   Map<String, int> supplierNameToId = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   // Future<void> _loadDropdownData() async {
//   //   try {
//   //     // Fetch items and suppliers concurrently for better performance
//   //     final [itemList, supplierList] = await Future.wait([
//   //       ApiService.fetchItems().catchError(
//   //         (_) => [],
//   //       ), // Fallback to empty list if items fail
//   //       ApiService.fetchSuppliers(),
//   //     ]);

//   //     final itemSet = <String>{};
//   //     final itemTypeMap = <String, List<String>>{};
//   //     final itemIdMap = <String, int>{};
//   //     final itemTypeIdMap = <String, Map<String, int>>{};

//   //     for (var item in itemList) {
//   //       final itemName = item['name'];
//   //       final type = item['type'];
//   //       final id = item['id'];

//   //       itemSet.add(itemName);
//   //       itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//   //       itemIdMap[itemName] = id;
//   //       itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//   //     }

//   //     // Ensure suppliers are populated even if items fail
//   //     final supplierNames = <String>[];
//   //     final supplierIds = <String, int>{};
//   //     for (var s in supplierList) {
//   //       supplierNames.add(s['name']);
//   //       supplierIds[s['name']] = s['id'];
//   //     }

//   //     setState(() {
//   //       items = itemSet.toList();
//   //       types = itemTypeMap;
//   //       itemNameToId = itemIdMap;
//   //       itemTypeToId = itemTypeIdMap;
//   //       suppliers = supplierNames; // Always update suppliers
//   //       supplierNameToId = supplierIds;
//   //     });
//   //   } catch (e) {
//   //     print("Failed loading dropdown data: $e");
//   //     // Set empty suppliers as fallback to ensure dropdown renders
//   //     setState(() {
//   //       suppliers = [];
//   //       supplierNameToId = {};
//   //     });
//   //   }
//   // }

//   // Inside _PurchaseFormState class
//   Future<void> _loadDropdownData() async {
//     try {
//       // Fetch items and suppliers concurrently for better performance
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError(
//           (e) => <Map<String, dynamic>>[],
//         ), // Return empty list with correct type
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       // Ensure suppliers are populated even if items fail
//       final supplierNames = <String>[];
//       final supplierIds = <String, int>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames; // Always update suppliers
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       // Set empty suppliers as fallback to ensure dropdown renders
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Type'),
//             ] else ...[
//               // Restore original logic for existing items
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['Cash', 'Bank'],
//                 onChanged: (val) => setState(() => paymentMethod = val),
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 10,
//           ),
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
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children:
//             ['PAID', 'UnPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];

//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'method': paymentStatus == 'PAID' ? paymentMethod : null,
//       'bank_account': paymentMethod == 'Bank' ? "Meezan" : null,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

// New code with many changes

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
//   String paymentStatus = 'UnPAID';
//   String? paymentMethod;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id

//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId =
//       {}; // Changed from Map<String, int> to Map<String, String>

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       // Fetch items and suppliers concurrently for better performance
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       // Ensure suppliers are populated even if items fail
//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id']; // Use string UUID
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['Cash', 'Bank'],
//                 onChanged: (val) => setState(() => paymentMethod = val),
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 10,
//           ),
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
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children:
//             ['PAID', 'UnPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];

//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'method': paymentStatus == 'PAID' ? paymentMethod : null,
//       'bank_account': paymentMethod == 'Bank' ? "Meezan" : null,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id

//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId =
//       {}; // Changed from Map<String, int> to Map<String, String>

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['Cash', 'Bank'],
//                 onChanged: (val) => setState(() => paymentMethod = val),
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 10,
//           ),
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
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];

//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem)
//         'item_name': newItemNameController.text, // Add for new items
//       if (isNewItem)
//         'item_type': newItemTypeController.text, // Add for new items
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'method': paymentStatus == 'PAID' ? paymentMethod : null,
//       'bank_account': paymentMethod == 'Bank' ? "Meezan" : null,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

// Added bank account in dropdown

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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;
//   String? selectedBankAccount; // New state for bank account

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();
//   final TextEditingController newBankAccountController =
//       TextEditingController(); // New controller for bank account input

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {}; // item -> type -> id
//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId =
//       {}; // Changed from Map<String, int> to Map<String, String>
//   // Update bankAccounts to match enum member names
//   List<String> bankAccounts = [
//     'MEEZAN',
//     'HBL',
//     'UBL',
//   ]; // Match PaymentMethod and BankAccounts enum member names

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: [
//                   'CASH',
//                   'BANK',
//                 ], // Match PaymentMethod enum member names
//                 onChanged: (val) {
//                   setState(() {
//                     paymentMethod = val;
//                     if (val == 'BANK' && selectedBankAccount == null) {
//                       selectedBankAccount =
//                           bankAccounts.isNotEmpty ? bankAccounts[0] : null;
//                     }
//                   });
//                 },
//               ),
//             if (paymentStatus == 'PAID' && paymentMethod == 'BANK')
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDropdown<String>(
//                     label: 'Select Bank Account',
//                     value: selectedBankAccount,
//                     items: bankAccounts,
//                     onChanged:
//                         (val) => setState(() => selectedBankAccount = val),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildInputField(
//                     newBankAccountController,
//                     'New Bank Account (optional)',
//                   ),
//                   const SizedBox(height: 5),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (newBankAccountController.text.isNotEmpty &&
//                           !bankAccounts.contains(
//                             newBankAccountController.text,
//                           )) {
//                         setState(() {
//                           bankAccounts.add(newBankAccountController.text);
//                           selectedBankAccount = newBankAccountController.text;
//                           newBankAccountController.clear();
//                         });
//                       }
//                     },
//                     child: const Text('Add New Bank Account'),
//                   ),
//                 ],
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items.map((item) {
//                     return DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 10,
//           ),
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
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     if (paymentStatus == 'PAID' &&
//         (paymentMethod == null ||
//             (paymentMethod == 'BANK' && selectedBankAccount == null))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a payment method and bank account if applicable",
//           ),
//         ),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];

//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem) 'item_name': newItemNameController.text,
//       if (isNewItem) 'item_type': newItemTypeController.text,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'payment_method':
//           paymentStatus == 'PAID'
//               ? paymentMethod
//               : null, // Use exact enum names
//       if (paymentMethod == 'BANK' && selectedBankAccount != null)
//         'bank_account':
//             selectedBankAccount, // Send bank account only for BANK method
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       print("Sending purchase data: $purchaseData"); // Debug log
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

// Adjustments for new dropdown

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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;
//   String? selectedBankAccount;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();
//   final TextEditingController newBankAccountController =
//       TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {};
//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId = {};
//   List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['CASH', 'BANK'],
//                 onChanged: (val) {
//                   setState(() {
//                     paymentMethod = val;
//                     if (val == 'BANK' && selectedBankAccount == null) {
//                       selectedBankAccount =
//                           bankAccounts.isNotEmpty ? bankAccounts[0] : null;
//                     }
//                   });
//                 },
//               ),
//             if (paymentStatus == 'PAID' && paymentMethod == 'BANK') ...[
//               _buildDropdown<String>(
//                 label: 'Select Bank Account',
//                 value: selectedBankAccount,
//                 items: bankAccounts,
//                 onChanged: (val) => setState(() => selectedBankAccount = val),
//               ),
//               SizedBox(
//                 width: 150,
//                 height: 40,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     _showAddBankAccountDialog(context);
//                   },
//                   icon: Icon(Icons.add, size: 16),
//                   label: Text('Add Account'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 20),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   void _showAddBankAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add New Bank Account'),
//           content: TextField(
//             controller: newBankAccountController,
//             decoration: InputDecoration(
//               hintText: 'Enter new bank name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (newBankAccountController.text.isNotEmpty &&
//                     !bankAccounts.contains(newBankAccountController.text)) {
//                   setState(() {
//                     bankAccounts.add(newBankAccountController.text);
//                     selectedBankAccount = newBankAccountController.text;
//                     newBankAccountController.clear();
//                   });
//                 }
//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items
//                       .map(
//                         (item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 12),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
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

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 10,
//           ),
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
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 40,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     if (paymentStatus == 'PAID' &&
//         (paymentMethod == null ||
//             (paymentMethod == 'BANK' && selectedBankAccount == null))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a payment method and bank account if applicable",
//           ),
//         ),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];
//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem) 'item_name': newItemNameController.text,
//       if (isNewItem) 'item_type': newItemTypeController.text,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
//       if (paymentMethod == 'BANK' && selectedBankAccount != null)
//         'bank_account': selectedBankAccount,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       print("Sending purchase data: $purchaseData");
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

// Adjustment with reduced vertical spacing

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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;
//   String? selectedBankAccount;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();
//   final TextEditingController newBankAccountController =
//       TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {};
//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId = {};
//   List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       print("Failed loading dropdown data: $e");
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['CASH', 'BANK'],
//                 onChanged: (val) {
//                   setState(() {
//                     paymentMethod = val;
//                     if (val == 'BANK' && selectedBankAccount == null) {
//                       selectedBankAccount =
//                           bankAccounts.isNotEmpty ? bankAccounts[0] : null;
//                     }
//                   });
//                 },
//               ),
//             if (paymentStatus == 'PAID' && paymentMethod == 'BANK') ...[
//               _buildDropdown<String>(
//                 label: 'Select Bank Account',
//                 value: selectedBankAccount,
//                 items: bankAccounts,
//                 onChanged: (val) => setState(() => selectedBankAccount = val),
//               ),
//               SizedBox(
//                 width: 150,
//                 height: 36,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     _showAddBankAccountDialog(context);
//                   },
//                   icon: Icon(Icons.add, size: 16),
//                   label: Text('Add Account'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 12),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   void _showAddBankAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add New Bank Account'),
//           content: TextField(
//             controller: newBankAccountController,
//             decoration: InputDecoration(
//               hintText: 'Enter new bank name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (newBankAccountController.text.isNotEmpty &&
//                     !bankAccounts.contains(newBankAccountController.text)) {
//                   setState(() {
//                     bankAccounts.add(newBankAccountController.text);
//                     selectedBankAccount = newBankAccountController.text;
//                     newBankAccountController.clear();
//                   });
//                 }
//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items
//                       .map(
//                         (item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 8),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 8),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label.isNotEmpty ? label : null,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 36,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 6,
//           ),
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
//       height: 36,
//       child: DropdownButtonFormField<T>(
//         value: value,
//         isExpanded: true,
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 170,
//       height: 36,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }

//   Widget _buildPurchaseButton() {
//     return SizedBox(
//       width: 120,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: _submitPurchase,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue[900],
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text('Purchase'),
//       ),
//     );
//   }

//   Widget _buildNewItemButton() {
//     return SizedBox(
//       height: 36,
//       child: ElevatedButton(
//         onPressed: () => setState(() => isNewItem = !isNewItem),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF55221),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 18),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     if (paymentStatus == 'PAID' &&
//         (paymentMethod == null ||
//             (paymentMethod == 'BANK' && selectedBankAccount == null))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a payment method and bank account if applicable",
//           ),
//         ),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];
//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem) 'item_name': newItemNameController.text,
//       if (isNewItem) 'item_type': newItemTypeController.text,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
//       if (paymentMethod == 'BANK' && selectedBankAccount != null)
//         'bank_account': selectedBankAccount,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       print("Sending purchase data: $purchaseData");
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       print("ERROR: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;
//   String? selectedBankAccount;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();
//   final TextEditingController newBankAccountController =
//       TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {};
//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId = {};
//   List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 6,
//           runSpacing: 6,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['CASH', 'BANK'],
//                 onChanged: (val) {
//                   setState(() {
//                     paymentMethod = val;
//                     if (val == 'BANK' && selectedBankAccount == null) {
//                       selectedBankAccount =
//                           bankAccounts.isNotEmpty ? bankAccounts[0] : null;
//                     }
//                   });
//                 },
//               ),
//             if (paymentStatus == 'PAID' && paymentMethod == 'BANK')
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildDropdown<String>(
//                     label: 'Select Bank Account',
//                     value: selectedBankAccount,
//                     items: bankAccounts,
//                     onChanged:
//                         (val) => setState(() => selectedBankAccount = val),
//                   ),
//                   const SizedBox(width: 4),
//                   SizedBox(
//                     height: 36,
//                     child: ElevatedButton.icon(
//                       onPressed: () => _showAddBankAccountDialog(context),
//                       icon: const Icon(Icons.add, size: 16),
//                       label: const Text('Add Account'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 12),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   void _showAddBankAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add New Bank Account'),
//           content: TextField(
//             controller: newBankAccountController,
//             decoration: const InputDecoration(
//               hintText: 'Enter new bank name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (newBankAccountController.text.isNotEmpty &&
//                     !bankAccounts.contains(newBankAccountController.text)) {
//                   setState(() {
//                     bankAccounts.add(newBankAccountController.text);
//                     selectedBankAccount = newBankAccountController.text;
//                     newBankAccountController.clear();
//                   });
//                 }
//                 Navigator.pop(context);
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items
//                       .map(
//                         (item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 8),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]?.map((type) {
//                       return DropdownMenuItem<String>(
//                         value: type,
//                         child: Text(type),
//                       );
//                     }).toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 8),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label.isNotEmpty ? label : null,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 150,
//       height: 36,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 6,
//           ),
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
//       width: 150,
//       height: 36,
//       child: DropdownButtonFormField<T>(
//         value: value,
//         isExpanded: true,
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 160,
//       height: 36,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 2),
//                   child: ElevatedButton(
//                     onPressed: () => setState(() => paymentStatus = label),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }

//   Widget _buildPurchaseButton() {
//     return SizedBox(
//       width: 110,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: _submitPurchase,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue[900],
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text('Purchase'),
//       ),
//     );
//   }

//   Widget _buildNewItemButton() {
//     return SizedBox(
//       width: 110,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: () => setState(() => isNewItem = !isNewItem),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF55221),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 16),
//             if (!isNewItem) const SizedBox(width: 4),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     if (paymentStatus == 'PAID' &&
//         (paymentMethod == null ||
//             (paymentMethod == 'BANK' && selectedBankAccount == null))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a payment method and bank account if applicable",
//           ),
//         ),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];
//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem) 'item_name': newItemNameController.text,
//       if (isNewItem) 'item_type': newItemTypeController.text,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
//       if (paymentMethod == 'BANK' && selectedBankAccount != null)
//         'bank_account': selectedBankAccount,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;
//   String? selectedBankAccount;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();
//   final TextEditingController newBankAccountController =
//       TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {};
//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId = {};
//   List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//     _loadBankAccounts();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final [itemList, supplierList] = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = item['id'];

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   Future<void> _loadBankAccounts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedAccounts = prefs.getStringList('bankAccounts');
//     if (savedAccounts != null && savedAccounts.isNotEmpty) {
//       setState(() {
//         bankAccounts = savedAccounts;
//       });
//     }
//   }

//   Future<void> _saveBankAccounts() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('bankAccounts', bankAccounts);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 6,
//           runSpacing: 6,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['CASH', 'BANK'],
//                 onChanged:
//                     (val) => setState(() {
//                       paymentMethod = val;
//                       if (val != 'BANK') {
//                         selectedBankAccount = null;
//                       }
//                     }),
//               ),
//             if (paymentStatus == 'PAID' && paymentMethod == 'BANK')
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildDropdown<String>(
//                     label: 'Select Bank Account',
//                     value: selectedBankAccount,
//                     items: bankAccounts,
//                     onChanged:
//                         (val) => setState(() => selectedBankAccount = val),
//                   ),
//                   const SizedBox(width: 4),
//                   SizedBox(
//                     height: 36,
//                     child: ElevatedButton.icon(
//                       onPressed: () => _showAddBankAccountDialog(context),
//                       icon: const Icon(Icons.add, size: 16),
//                       label: const Text('Add Account'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 12),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   void _showAddBankAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add New Bank Account'),
//           content: TextField(
//             controller: newBankAccountController,
//             decoration: const InputDecoration(
//               hintText: 'Enter new bank name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (newBankAccountController.text.isNotEmpty &&
//                     !bankAccounts.contains(newBankAccountController.text)) {
//                   setState(() {
//                     bankAccounts.add(newBankAccountController.text);
//                     selectedBankAccount = newBankAccountController.text;
//                     newBankAccountController.clear();
//                   });
//                   await _saveBankAccounts();
//                 }
//                 Navigator.pop(context);
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items
//                       .map(
//                         (item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 8),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]
//                         ?.map(
//                           (type) => DropdownMenuItem<String>(
//                             value: type,
//                             child: Text(type),
//                           ),
//                         )
//                         .toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 8),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label.isNotEmpty ? label : null,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 150,
//       height: 36,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 6,
//           ),
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
//       width: 150,
//       height: 36,
//       child: DropdownButtonFormField<T>(
//         value: value,
//         isExpanded: true,
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 160,
//       height: 36,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 2),
//                   child: ElevatedButton(
//                     onPressed:
//                         () => setState(() {
//                           paymentStatus = label;
//                           if (paymentStatus == 'PAID') {
//                             paymentMethod = null;
//                             selectedBankAccount = null;
//                           }
//                         }),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }

//   Widget _buildPurchaseButton() {
//     return SizedBox(
//       width: 110,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: _submitPurchase,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue[900],
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text('Purchase'),
//       ),
//     );
//   }

//   Widget _buildNewItemButton() {
//     return SizedBox(
//       width: 110,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: () => setState(() => isNewItem = !isNewItem),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF55221),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 16),
//             if (!isNewItem) const SizedBox(width: 4),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     if (paymentStatus == 'PAID' &&
//         (paymentMethod == null ||
//             (paymentMethod == 'BANK' && selectedBankAccount == null))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a payment method and bank account if applicable",
//           ),
//         ),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];
//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem) 'item_name': newItemNameController.text,
//       if (isNewItem) 'item_type': newItemTypeController.text,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
//       if (paymentMethod == 'BANK' && selectedBankAccount != null)
//         'bank_account': selectedBankAccount,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//       _resetFormFields(); // reset fields after success
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }

//   void _resetFormFields() {
//     setState(() {
//       isNewItem = false;
//       selectedItem = null;
//       selectedType = null;
//       selectedSupplier = null;
//       paymentStatus = 'UNPAID';
//       paymentMethod = null;
//       selectedBankAccount = null;
//       quantityController.clear();
//       amountController.clear();
//       newItemNameController.clear();
//       newItemTypeController.clear();
//     });
//   }
// }

// Corrected item list

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
//   String paymentStatus = 'UNPAID';
//   String? paymentMethod;
//   String? selectedBankAccount;

//   String? selectedFilter;
//   String? selectedFilterValue;

//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController newItemNameController = TextEditingController();
//   final TextEditingController newItemTypeController = TextEditingController();
//   final TextEditingController newBankAccountController =
//       TextEditingController();

//   List<String> items = [];
//   Map<String, List<String>> types = {};
//   Map<String, int> itemNameToId = {};
//   Map<String, Map<String, int>> itemTypeToId = {};
//   List<String> suppliers = [];
//   Map<String, String> supplierNameToId = {};
//   List<String> bankAccounts = ['MEEZAN', 'HBL', 'UBL'];

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//     _loadBankAccounts();
//   }

//   Future<void> _loadDropdownData() async {
//     try {
//       final results = await Future.wait([
//         ApiService.fetchItems().catchError((e) => <Map<String, dynamic>>[]),
//         ApiService.fetchSuppliers(),
//       ]);
//       final itemList = results[0];
//       final supplierList = results[1];

//       final itemSet = <String>{};
//       final itemTypeMap = <String, List<String>>{};
//       final itemIdMap = <String, int>{};
//       final itemTypeIdMap = <String, Map<String, int>>{};

//       for (var item in itemList) {
//         final itemName = item['name'];
//         final type = item['type'];
//         final id = int.tryParse(item['item_id'].toString()) ?? 0;

//         itemSet.add(itemName);
//         itemTypeMap[itemName] = [...?itemTypeMap[itemName], type];
//         itemIdMap[itemName] = id;
//         itemTypeIdMap[itemName] = {...?itemTypeIdMap[itemName], type: id};
//       }

//       final supplierNames = <String>[];
//       final supplierIds = <String, String>{};
//       for (var s in supplierList) {
//         supplierNames.add(s['name']);
//         supplierIds[s['name']] = s['supplier_id'];
//       }

//       setState(() {
//         items = itemSet.toList();
//         types = itemTypeMap;
//         itemNameToId = itemIdMap;
//         itemTypeToId = itemTypeIdMap;
//         suppliers = supplierNames;
//         supplierNameToId = supplierIds;
//       });
//     } catch (e) {
//       setState(() {
//         suppliers = [];
//         supplierNameToId = {};
//       });
//     }
//   }

//   Future<void> _loadBankAccounts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedAccounts = prefs.getStringList('bankAccounts');
//     if (savedAccounts != null && savedAccounts.isNotEmpty) {
//       setState(() {
//         bankAccounts = savedAccounts;
//       });
//     }
//   }

//   Future<void> _saveBankAccounts() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('bankAccounts', bankAccounts);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 6,
//           runSpacing: 6,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             if (isNewItem) ...[
//               _buildInputField(newItemNameController, 'Item Name'),
//               _buildInputField(newItemTypeController, 'Category'),
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
//                   items: types[selectedItem] ?? [],
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
//             if (paymentStatus == 'PAID')
//               _buildDropdown<String>(
//                 label: 'Payment Method',
//                 value: paymentMethod,
//                 items: ['CASH', 'BANK'],
//                 onChanged:
//                     (val) => setState(() {
//                       paymentMethod = val;
//                       if (val != 'BANK') {
//                         selectedBankAccount = null;
//                       }
//                     }),
//               ),
//             if (paymentStatus == 'PAID' && paymentMethod == 'BANK')
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildDropdown<String>(
//                     label: 'Select Bank Account',
//                     value: selectedBankAccount,
//                     items: bankAccounts,
//                     onChanged:
//                         (val) => setState(() => selectedBankAccount = val),
//                   ),
//                   const SizedBox(width: 4),
//                   SizedBox(
//                     height: 36,
//                     child: ElevatedButton.icon(
//                       onPressed: () => _showAddBankAccountDialog(context),
//                       icon: const Icon(Icons.add, size: 16),
//                       label: const Text('Add Account'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             _buildPurchaseButton(),
//             _buildNewItemButton(),
//           ],
//         ),
//         const SizedBox(height: 12),
//         _buildFilterUI(),
//       ],
//     );
//   }

//   void _showAddBankAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add New Bank Account'),
//           content: TextField(
//             controller: newBankAccountController,
//             decoration: const InputDecoration(
//               hintText: 'Enter new bank name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (newBankAccountController.text.isNotEmpty &&
//                     !bankAccounts.contains(newBankAccountController.text)) {
//                   setState(() {
//                     bankAccounts.add(newBankAccountController.text);
//                     selectedBankAccount = newBankAccountController.text;
//                     newBankAccountController.clear();
//                   });
//                   await _saveBankAccounts();
//                 }
//                 Navigator.pop(context);
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildFilterUI() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 180,
//             child: DropdownButtonFormField<String>(
//               value: selectedFilter,
//               hint: const Text('Select Item'),
//               decoration: _dropdownDecoration(''),
//               items:
//                   items
//                       .map(
//                         (item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFilter = value;
//                   selectedFilterValue = null;
//                 });
//               },
//             ),
//           ),
//           const SizedBox(width: 8),
//           if (selectedFilter != null)
//             SizedBox(
//               width: 180,
//               child: DropdownButtonFormField<String>(
//                 value: selectedFilterValue,
//                 hint: const Text('Select Type'),
//                 decoration: _dropdownDecoration(''),
//                 items:
//                     types[selectedFilter]
//                         ?.map(
//                           (type) => DropdownMenuItem<String>(
//                             value: type,
//                             child: Text(type),
//                           ),
//                         )
//                         .toList() ??
//                     [],
//                 onChanged: (value) {
//                   setState(() => selectedFilterValue = value);
//                 },
//               ),
//             ),
//           const SizedBox(width: 8),
//           const Icon(Icons.filter_list),
//           const SizedBox(width: 4),
//           const Text('Filter'),
//         ],
//       ),
//     );
//   }

//   InputDecoration _dropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label.isNotEmpty ? label : null,
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }

//   Widget _buildInputField(
//     TextEditingController controller,
//     String label, {
//     bool isNumber = false,
//   }) {
//     return SizedBox(
//       width: 150,
//       height: 36,
//       child: TextField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 6,
//           ),
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
//       width: 150,
//       height: 36,
//       child: DropdownButtonFormField<T>(
//         value: value,
//         isExpanded: true,
//         decoration: _dropdownDecoration(label),
//         items:
//             items
//                 .map(
//                   (item) => DropdownMenuItem<T>(
//                     value: item,
//                     child: Text(item.toString()),
//                   ),
//                 )
//                 .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   Widget _buildPaymentStatusButtons() {
//     return SizedBox(
//       width: 160,
//       height: 36,
//       child: Row(
//         children:
//             ['PAID', 'UNPAID'].map((label) {
//               final isActive = paymentStatus == label;
//               return Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 2),
//                   child: ElevatedButton(
//                     onPressed:
//                         () => setState(() {
//                           paymentStatus = label;
//                           if (paymentStatus == 'PAID') {
//                             paymentMethod = null;
//                             selectedBankAccount = null;
//                           }
//                         }),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isActive ? const Color(0xFFF55221) : Colors.grey,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(label),
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }

//   Widget _buildPurchaseButton() {
//     return SizedBox(
//       width: 110,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: _submitPurchase,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue[900],
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text('Purchase'),
//       ),
//     );
//   }

//   Widget _buildNewItemButton() {
//     return SizedBox(
//       width: 110,
//       height: 36,
//       child: ElevatedButton(
//         onPressed: () => setState(() => isNewItem = !isNewItem),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF55221),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (!isNewItem) const Icon(Icons.add, size: 16),
//             if (!isNewItem) const SizedBox(width: 4),
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
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
//       return;
//     }

//     if (paymentStatus == 'PAID' &&
//         (paymentMethod == null ||
//             (paymentMethod == 'BANK' && selectedBankAccount == null))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a payment method and bank account if applicable",
//           ),
//         ),
//       );
//       return;
//     }

//     final quantity = int.tryParse(quantityController.text) ?? 0;
//     final amount = double.tryParse(amountController.text) ?? 0.0;
//     final total = quantity * amount;

//     final itemId = isNewItem ? null : itemTypeToId[selectedItem]?[selectedType];
//     final supplierId = supplierNameToId[selectedSupplier!];

//     final purchaseData = {
//       'item_id': itemId,
//       if (isNewItem) 'item_name': newItemNameController.text,
//       if (isNewItem) 'item_type': newItemTypeController.text,
//       'supplier_id': supplierId,
//       'quantity': quantity,
//       'unit_price': amount,
//       'total_amount': total,
//       'payment_status': paymentStatus,
//       'payment_method': paymentStatus == 'PAID' ? paymentMethod : null,
//       if (paymentMethod == 'BANK' && selectedBankAccount != null)
//         'bank_account': selectedBankAccount,
//       'purchase_date': DateTime.now().toIso8601String(),
//     };

//     try {
//       await ApiService.submitPurchase(purchaseData);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Purchase created successfully")),
//       );
//       _resetFormFields();
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Error creating purchase")));
//     }
//   }

//   void _resetFormFields() {
//     setState(() {
//       isNewItem = false;
//       selectedItem = null;
//       selectedType = null;
//       selectedSupplier = null;
//       paymentStatus = 'UNPAID';
//       paymentMethod = null;
//       selectedBankAccount = null;
//       quantityController.clear();
//       amountController.clear();
//       newItemNameController.clear();
//       newItemTypeController.clear();
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String paymentStatus = 'UNPAID';
  String? paymentMethod;
  String? selectedBankAccount;

  String? selectedFilter;
  String? selectedFilterValue;

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController newItemNameController = TextEditingController();
  final TextEditingController newItemTypeController = TextEditingController();
  final TextEditingController newBankAccountController =
      TextEditingController();

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
    return Column(
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
                  _buildDropdown<String>(
                    label: 'Select Bank Account',
                    value: selectedBankAccount,
                    items: bankAccounts,
                    onChanged:
                        (val) => setState(() => selectedBankAccount = val),
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
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
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
              items:
                  items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value;
                  selectedFilterValue = null;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          if (selectedFilter != null)
            SizedBox(
              width: 180,
              child: DropdownButtonFormField<String>(
                value: selectedFilterValue,
                hint: const Text('Select Type'),
                decoration: _dropdownDecoration(''),
                items:
                    types[selectedFilter]
                        ?.map(
                          (type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ),
                        )
                        .toList() ??
                    [],
                onChanged: (value) {
                  setState(() => selectedFilterValue = value);
                },
              ),
            ),
          const SizedBox(width: 8),
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
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: true,
        decoration: _dropdownDecoration(label),
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
      await _loadDropdownData(); // refresh item list dynamically
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

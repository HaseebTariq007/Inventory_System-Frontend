// // import 'package:flutter/material.dart';
// // import '../widgets/custom_nav_bar.dart';

// // class StockListScreen extends StatefulWidget {
// //   const StockListScreen({Key? key}) : super(key: key);

// //   @override
// //   _StockListScreenState createState() => _StockListScreenState();
// // }

// // class _StockListScreenState extends State<StockListScreen> {
// //   final List<Map<String, dynamic>> allStock = [
// //     {'item': 'Inverter-body', 'type': '18KW', 'quantity': 10, 'total': 5000},
// //     {'item': 'Inverter-body', 'type': '20KW', 'quantity': 8, 'total': 4800},
// //     {'item': 'Solar Panel', 'type': '100W', 'quantity': 12, 'total': 3600},
// //     {'item': 'Solar Panel', 'type': '200W', 'quantity': 6, 'total': 3000},
// //   ];

// //   String? selectedItem;
// //   String? selectedType;
// //   int currentPage = 0;
// //   final int itemsPerPage = 2;

// //   List<String> get itemNames =>
// //       allStock.map((e) => e['item'].toString()).toSet().toList();

// //   List<String> get typesForSelectedItem => selectedItem == null
// //       ? []
// //       : allStock
// //           .where((e) => e['item'] == selectedItem)
// //           .map((e) => e['type'].toString())
// //           .toSet()
// //           .toList();

// //   List<Map<String, dynamic>> get filteredStock {
// //     List<Map<String, dynamic>> filtered = allStock;
// //     if (selectedItem != null) {
// //       filtered = filtered.where((e) => e['item'] == selectedItem).toList();
// //     }
// //     if (selectedType != null) {
// //       filtered = filtered.where((e) => e['type'] == selectedType).toList();
// //     }
// //     return filtered;
// //   }

// //   List<Map<String, dynamic>> get paginatedStock {
// //     int start = currentPage * itemsPerPage;
// //     int end = start + itemsPerPage;
// //     return filteredStock.sublist(start, end > filteredStock.length ? filteredStock.length : end);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFFCF7FC),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFF55221),
// //         title: const Text('Stock List'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(12),
// //         child: Column(
// //           children: [
// //             /// Top container with dropdowns
// //             Material(
// //               elevation: 2,
// //               borderRadius: BorderRadius.circular(10),
// //               child: Container(
// //                 padding: const EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(10),
// //                   color: Colors.white,
// //                 ),
// //                 child: Wrap(
// //                   spacing: 12,
// //                   runSpacing: 12,
// //                   crossAxisAlignment: WrapCrossAlignment.center,
// //                   children: [
// //                     _buildDropdown(
// //                       label: 'Select Item',
// //                       value: selectedItem,
// //                       items: itemNames,
// //                       onChanged: (val) {
// //                         setState(() {
// //                           selectedItem = val;
// //                           selectedType = null;
// //                           currentPage = 0;
// //                         });
// //                       },
// //                     ),
// //                     if (selectedItem != null)
// //                       _buildDropdown(
// //                         label: 'Select Type',
// //                         value: selectedType,
// //                         items: typesForSelectedItem,
// //                         onChanged: (val) {
// //                           setState(() {
// //                             selectedType = val;
// //                             currentPage = 0;
// //                           });
// //                         },
// //                       ),
// //                     Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: const [
// //                         Icon(Icons.filter_list, size: 18),
// //                         SizedBox(width: 6),
// //                         Text("Filter", style: TextStyle(fontSize: 14)),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 16),

// //             /// Table container
// //             Expanded(
// //               child: Material(
// //                 elevation: 2,
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 8),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: SingleChildScrollView(
// //                     scrollDirection: Axis.vertical,
// //                     child: DataTable(
// //                       columns: const [
// //                         DataColumn(label: Text('Item')),
// //                         DataColumn(label: Text('Type')),
// //                         DataColumn(label: Text('Quantity')),
// //                         DataColumn(label: Text('Unit Price')),
// //                       ],
// //                       rows: paginatedStock.map((stock) {
// //                         final unitPrice =
// //                             (stock['total'] / stock['quantity']).toStringAsFixed(2);
// //                         return DataRow(cells: [
// //                           DataCell(Text(stock['item'])),
// //                           DataCell(Text(stock['type'])),
// //                           DataCell(Text(stock['quantity'].toString())),
// //                           DataCell(Text('\$$unitPrice')),
// //                         ]);
// //                       }).toList(),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 16),

// //             /// Pagination
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.grey.shade300,
// //                     foregroundColor: Colors.black,
// //                   ),
// //                   onPressed: currentPage > 0 ? () => setState(() => currentPage--) : null,
// //                   child: const Text("Previous"),
// //                 ),
// //                 const SizedBox(width: 16),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.grey.shade300,
// //                     foregroundColor: Colors.black,
// //                   ),
// //                   onPressed: (currentPage + 1) * itemsPerPage < filteredStock.length
// //                       ? () => setState(() => currentPage++)
// //                       : null,
// //                   child: const Text("Next"),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDropdown({
// //     required String label,
// //     required String? value,
// //     required List<String> items,
// //     required void Function(String?)? onChanged,
// //   }) {
// //     return SizedBox(
// //       width: 160,
// //       height: 40,
// //       child: DropdownButtonFormField<String>(
// //         value: value,
// //         isExpanded: true,
// //         decoration: InputDecoration(
// //           labelText: label,
// //           filled: true,
// //           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //           fillColor: Colors.grey.shade100,
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(10),
// //             borderSide: BorderSide.none,
// //           ),
// //         ),
// //         items: items
// //             .map((item) => DropdownMenuItem<String>(
// //                   value: item,
// //                   child: Text(item),
// //                 ))
// //             .toList(),
// //         onChanged: onChanged,
// //       ),
// //     );
// //   }
// // }

// //New Code

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets/custom_nav_bar.dart';
// import '../state/stock_provider.dart';

// class StockListScreen extends StatefulWidget {
//   const StockListScreen({Key? key}) : super(key: key);

//   @override
//   _StockListScreenState createState() => _StockListScreenState();
// }

// class _StockListScreenState extends State<StockListScreen> {
//   String? selectedItem;
//   String? selectedType;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<StockProvider>(context, listen: false).fetchStock();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stockProvider = Provider.of<StockProvider>(context);

//     final filteredStock = stockProvider.stocks.where((stock) {
//       final matchesItem = selectedItem == null || stock['item_name'] == selectedItem;
//       final matchesType = selectedType == null || stock['item_type'] == selectedType;
//       return matchesItem && matchesType;
//     }).toList();

//     final paginatedStock = filteredStock.skip((stockProvider.currentPage - 1) * stockProvider.limit).take(stockProvider.limit).toList();

//     final itemNames = stockProvider.stocks.map((s) => s['item_name'] as String).toSet().toList();
//     final itemTypes = selectedItem == null
//         ? []
//         : stockProvider.stocks
//             .where((s) => s['item_name'] == selectedItem)
//             .map((s) => s['item_type'] as String)
//             .toSet()
//             .toList();

//     return Scaffold(
//       appBar: const CustomNavBar(title: 'Stock List'),
//       backgroundColor: const Color(0xFFFAF9FB),
//       body: Column(
//         children: [
//           /// Filters
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(16),
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
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 180,
//                   child: DropdownButtonFormField<String>(
//                     value: selectedItem,
//                     hint: const Text('Select Item'),
//                     decoration: _dropdownDecoration(),
//                     items: itemNames.map((item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedItem = value;
//                         selectedType = null;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 if (selectedItem != null)
//                   SizedBox(
//                     width: 180,
//                     child: DropdownButtonFormField<String>(
//                       value: selectedType,
//                       hint: const Text('Select Type'),
//                       decoration: _dropdownDecoration(),
//                       items: itemTypes.map((type) {
//                         return DropdownMenuItem<String>(
//                           value: type,
//                           child: Text(type),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() => selectedType = value);
//                       },
//                     ),
//                   ),
//                 const SizedBox(width: 12),
//                 const Icon(Icons.filter_list),
//                 const SizedBox(width: 4),
//                 const Text('Filter'),
//               ],
//             ),
//           ),

//           /// Table
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
//                 child: stockProvider.isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : stockProvider.error != null
//                         ? Center(child: Text(stockProvider.error!))
//                         : DataTable(
//                             columns: const [
//                               DataColumn(label: Text('Item Name')),
//                               DataColumn(label: Text('Quantity')),
//                               DataColumn(label: Text('Total Amount')),
//                               DataColumn(label: Text('Unit Price')),
//                             ],
//                             rows: paginatedStock.map((stock) {
//                               final unitPrice = stock['quantity'] != 0
//                                   ? (stock['total_amount'] / stock['quantity']).toStringAsFixed(2)
//                                   : '0.00';
//                               return DataRow(cells: [
//                                 DataCell(Text(stock['item_name'].toString())),
//                                 DataCell(Text(stock['quantity'].toString())),
//                                 DataCell(Text(stock['total_amount'].toString())),
//                                 DataCell(Text(unitPrice)),
//                               ]);
//                             }).toList(),
//                           ),
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
//                       value: stockProvider.limit,
//                       items: const [
//                         DropdownMenuItem(value: 10, child: Text('10')),
//                         DropdownMenuItem(value: 25, child: Text('25')),
//                         DropdownMenuItem(value: 50, child: Text('50')),
//                       ],
//                       onChanged: (int? newValue) {
//                         if (newValue != null) {
//                           stockProvider.changeLimit(newValue);
//                         }
//                       },
//                     ),
//                     const SizedBox(width: 20),
//                     ElevatedButton(
//                       onPressed: stockProvider.currentPage > 1
//                           ? () => stockProvider.previousPage()
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF55221),
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text('Previous'),
//                     ),
//                   ],
//                 ),
//                 Text('Page ${stockProvider.currentPage}'),
//                 ElevatedButton(
//                   onPressed: () => stockProvider.nextPage(),
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

//   InputDecoration _dropdownDecoration() {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../widgets/custom_nav_bar.dart';

// class StockListScreen extends StatefulWidget {
//   const StockListScreen({Key? key}) : super(key: key);

//   @override
//   _StockListScreenState createState() => _StockListScreenState();
// }

// class _StockListScreenState extends State<StockListScreen> {
//   final List<Map<String, dynamic>> allStock = [
//     {'item': 'Inverter-body', 'type': '18KW', 'quantity': 10, 'total': 5000},
//     {'item': 'Inverter-body', 'type': '20KW', 'quantity': 8, 'total': 4800},
//     {'item': 'Solar Panel', 'type': '100W', 'quantity': 12, 'total': 3600},
//     {'item': 'Solar Panel', 'type': '200W', 'quantity': 6, 'total': 3000},
//   ];

//   String? selectedItem;
//   String? selectedType;
//   int currentPage = 0;
//   final int itemsPerPage = 2;

//   List<String> get itemNames =>
//       allStock.map((e) => e['item'].toString()).toSet().toList();

//   List<String> get typesForSelectedItem => selectedItem == null
//       ? []
//       : allStock
//           .where((e) => e['item'] == selectedItem)
//           .map((e) => e['type'].toString())
//           .toSet()
//           .toList();

//   List<Map<String, dynamic>> get filteredStock {
//     List<Map<String, dynamic>> filtered = allStock;
//     if (selectedItem != null) {
//       filtered = filtered.where((e) => e['item'] == selectedItem).toList();
//     }
//     if (selectedType != null) {
//       filtered = filtered.where((e) => e['type'] == selectedType).toList();
//     }
//     return filtered;
//   }

//   List<Map<String, dynamic>> get paginatedStock {
//     int start = currentPage * itemsPerPage;
//     int end = start + itemsPerPage;
//     return filteredStock.sublist(start, end > filteredStock.length ? filteredStock.length : end);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCF7FC),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF55221),
//         title: const Text('Stock List'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             /// Top container with dropdowns
//             Material(
//               elevation: 2,
//               borderRadius: BorderRadius.circular(10),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   children: [
//                     _buildDropdown(
//                       label: 'Select Item',
//                       value: selectedItem,
//                       items: itemNames,
//                       onChanged: (val) {
//                         setState(() {
//                           selectedItem = val;
//                           selectedType = null;
//                           currentPage = 0;
//                         });
//                       },
//                     ),
//                     if (selectedItem != null)
//                       _buildDropdown(
//                         label: 'Select Type',
//                         value: selectedType,
//                         items: typesForSelectedItem,
//                         onChanged: (val) {
//                           setState(() {
//                             selectedType = val;
//                             currentPage = 0;
//                           });
//                         },
//                       ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Icon(Icons.filter_list, size: 18),
//                         SizedBox(width: 6),
//                         Text("Filter", style: TextStyle(fontSize: 14)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             /// Table container
//             Expanded(
//               child: Material(
//                 elevation: 2,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: DataTable(
//                       columns: const [
//                         DataColumn(label: Text('Item')),
//                         DataColumn(label: Text('Type')),
//                         DataColumn(label: Text('Quantity')),
//                         DataColumn(label: Text('Unit Price')),
//                       ],
//                       rows: paginatedStock.map((stock) {
//                         final unitPrice =
//                             (stock['total'] / stock['quantity']).toStringAsFixed(2);
//                         return DataRow(cells: [
//                           DataCell(Text(stock['item'])),
//                           DataCell(Text(stock['type'])),
//                           DataCell(Text(stock['quantity'].toString())),
//                           DataCell(Text('\$$unitPrice')),
//                         ]);
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             /// Pagination
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey.shade300,
//                     foregroundColor: Colors.black,
//                   ),
//                   onPressed: currentPage > 0 ? () => setState(() => currentPage--) : null,
//                   child: const Text("Previous"),
//                 ),
//                 const SizedBox(width: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey.shade300,
//                     foregroundColor: Colors.black,
//                   ),
//                   onPressed: (currentPage + 1) * itemsPerPage < filteredStock.length
//                       ? () => setState(() => currentPage++)
//                       : null,
//                   child: const Text("Next"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required void Function(String?)? onChanged,
//   }) {
//     return SizedBox(
//       width: 160,
//       height: 40,
//       child: DropdownButtonFormField<String>(
//         value: value,
//         isExpanded: true,
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
//         items: items
//             .map((item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item),
//                 ))
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }

//New Code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_nav_bar.dart';
import '../state/stock_provider.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({Key? key}) : super(key: key);

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  String? selectedItem;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    Provider.of<StockProvider>(context, listen: false).fetchStockData();
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    final filteredStock = stockProvider.stocks.where((stock) {
      final matchesItem = selectedItem == null || stock['item_name'] == selectedItem;
      final matchesType = selectedType == null || stock['item_type'] == selectedType;
      return matchesItem && matchesType;
    }).toList();

    final paginatedStock = filteredStock.skip((stockProvider.currentPage - 1) * stockProvider.limit).take(stockProvider.limit).toList();

    final itemNames = stockProvider.stocks.map((s) => s['item_name'] as String).toSet().toList();
    final itemTypes = selectedItem == null
        ? []
        : stockProvider.stocks
            .where((s) => s['item_name'] == selectedItem)
            .map((s) => s['item_type'] as String)
            .toSet()
            .toList();

    return Scaffold(
      appBar: const CustomNavBar(title: 'Stock List'),
      backgroundColor: const Color(0xFFFAF9FB),
      body: Column(
        children: [
          /// Filters
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
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
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField<String>(
                    value: selectedItem,
                    hint: const Text('Select Item'),
                    decoration: _dropdownDecoration(),
                    items: itemNames.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value;
                        selectedType = null;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                if (selectedItem != null)
                  SizedBox(
                    width: 180,
                    child: DropdownButtonFormField<String>(
                      value: selectedType,
                      hint: const Text('Select Type'),
                      decoration: _dropdownDecoration(),
                      items: itemTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedType = value);
                      },
                    ),
                  ),
                const SizedBox(width: 12),
                const Icon(Icons.filter_list),
                const SizedBox(width: 4),
                const Text('Filter'),
              ],
            ),
          ),

          /// Table
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
                child: stockProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : stockProvider.error != null
                        ? Center(child: Text(stockProvider.error!))
                        : DataTable(
                            columns: const [
                              DataColumn(label: Text('Item Name')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Total Amount')),
                              DataColumn(label: Text('Unit Price')),
                            ],
                            rows: paginatedStock.map((stock) {
                              final unitPrice = stock['quantity'] != 0
                                  ? (stock['total_amount'] / stock['quantity']).toStringAsFixed(2)
                                  : '0.00';
                              return DataRow(cells: [
                                DataCell(Text(stock['item_name'].toString())),
                                DataCell(Text(stock['quantity'].toString())),
                                DataCell(Text(stock['total_amount'].toString())),
                                DataCell(Text(unitPrice)),
                              ]);
                            }).toList(),
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
                      value: stockProvider.limit,
                      items: const [
                        DropdownMenuItem(value: 10, child: Text('10')),
                        DropdownMenuItem(value: 25, child: Text('25')),
                        DropdownMenuItem(value: 50, child: Text('50')),
                      ],
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          stockProvider.changeLimit(newValue);
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: stockProvider.currentPage > 1
                          ? () => stockProvider.previousPage()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF55221),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Previous'),
                    ),
                  ],
                ),
                Text('Page ${stockProvider.currentPage}'),
                ElevatedButton(
                  onPressed: () => stockProvider.nextPage(),
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

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}


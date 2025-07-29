// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../widgets/component_sale_form.dart';
// import '../widgets/custom_nav_bar.dart';
// import '../state/component_sale_provider.dart';

// class ComponentSaleScreen extends StatefulWidget {
//   const ComponentSaleScreen({super.key});

//   @override
//   State<ComponentSaleScreen> createState() => _ComponentSaleScreenState();
// }

// class _ComponentSaleScreenState extends State<ComponentSaleScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ComponentSaleProvider(),
//       child: Scaffold(
//         appBar: const CustomNavBar(title: 'Item Sale'),
//         backgroundColor: const Color(0xFFFAF9FB),
//         body: SingleChildScrollView(
//           child: Container(
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
//                   'Item Sale',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 ComponentSaleForm(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../widgets/component_sale_form.dart';
import '../widgets/custom_nav_bar.dart';
import '../state/component_sale_provider.dart';

class ComponentSaleScreen extends StatefulWidget {
  const ComponentSaleScreen({super.key});

  @override
  State<ComponentSaleScreen> createState() => _ComponentSaleScreenState();
}

class _ComponentSaleScreenState extends State<ComponentSaleScreen> {
  List<Map<String, dynamic>> _pendingSales = [];
  double _totalAmount = 0.0;

  void _handleNewSale(Map<String, dynamic> saleData) {
    setState(() {
      _pendingSales.add(saleData);
      _totalAmount += double.tryParse(saleData['total_amount'].toString()) ?? 0.0;
    });
  }

//   Future<void> _generatePdf() async {
//     final pdf = pw.Document();
//     final date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('Item Sale Bill', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text('Date: $date'),
//             pw.SizedBox(height: 10),
//             pw.Table.fromTextArray(
//               headers: ['Item Name', 'Type', 'Customer', 'Qty', 'Amount', 'Payment Status', 'Payment Method'],
//               data: _pendingSales.map((sale) => [
//                 sale['item_name'],
//                 sale['item_type'],
//                 sale['customer_name'],
//                 sale['quantity'].toString(),
//                 sale['total_amount'].toString(),
//                 sale['payment_status'],
//                 sale['payment_method'] ?? '-'
//               ]).toList(),
//             ),
//             pw.SizedBox(height: 10),
//             pw.Text('Total Amount: $_totalAmount'),
//           ],
//         ),
//       ),
//     );

//     await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

//     setState(() {
//       _pendingSales.clear();
//       _totalAmount = 0.0;
//     });
//   }

Future<void> _generatePdf() async {
  final pdf = pw.Document();
  final date = DateFormat('yyyy-MM-dd_HH-mm').format(DateTime.now());

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Item Sale Bill', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text('Date: $date'),
          pw.SizedBox(height: 10),
          pw.Table.fromTextArray(
            headers: ['Item Name', 'Type', 'Customer', 'Qty', 'Amount', 'Payment Status', 'Payment Method'],
            data: _pendingSales.map((sale) => [
              sale['item_name'],
              sale['item_type'],
              sale['customer_name'],
              sale['quantity'].toString(),
              sale['total_amount'].toString(),
              sale['payment_status'],
              sale['payment_method'] ?? '-'
            ]).toList(),
          ),
          pw.SizedBox(height: 10),
          pw.Text('Total Amount: $_totalAmount'),
        ],
      ),
    ),
  );

  // Save to Downloads folder
  final downloadsDir = await getDownloadsDirectory();
  if (downloadsDir != null) {
    final file = File('${downloadsDir.path}/Item_Sale_Bill_$date.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved to: ${file.path}')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not access Downloads directory')),
    );
  }

  setState(() {
    _pendingSales.clear();
    _totalAmount = 0.0;
  });
}



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComponentSaleProvider(),
      child: Scaffold(
        appBar: const CustomNavBar(title: 'Item Sale'),
        backgroundColor: const Color(0xFFFAF9FB),
        body: SingleChildScrollView(
          child: Container(
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
                  'Item Sale',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                ComponentSaleForm(onSaleCreated: _handleNewSale),
                const SizedBox(height: 20),
                if (_pendingSales.isNotEmpty) ...[
                  const Divider(),
                  const Text(
                    'Pending Sales',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // child: DataTable(
                    //   columns: const [
                    //     DataColumn(label: Text('Item Name')),
                    //     DataColumn(label: Text('Type')),
                    //     DataColumn(label: Text('Customer')),
                    //     DataColumn(label: Text('Qty')),
                    //     DataColumn(label: Text('Amount')),
                    //     DataColumn(label: Text('Status')),
                    //     DataColumn(label: Text('Method')),
                    //   ],
                    //   rows: _pendingSales.map((sale) {
                    //     return DataRow(
                    //       cells: [
                    //         DataCell(Text(sale['item_name'] ?? '')),
                    //         DataCell(Text(sale['item_type'] ?? '')),
                    //         DataCell(Text(sale['customer_name'] ?? '')),
                    //         DataCell(Text(sale['quantity'].toString())),
                    //         DataCell(Text(sale['total_amount'].toString())),
                    //         DataCell(Text(sale['payment_status'] ?? '')),
                    //         DataCell(Text(sale['payment_method'] ?? '-')),
                    //       ],
                    //     );
                    //   }).toList(),
                    // ),
                     child: DataTable(
                      columns: const [
                            DataColumn(label: Text('Item Name')),
                            DataColumn(label: Text('Type')),
                            DataColumn(label: Text('Customer')),
                            DataColumn(label: Text('Qty')),
                            DataColumn(label: Text('Amount')),
                            DataColumn(label: Text('Payment Status')),
                            DataColumn(label: Text('Payment Method')),
                            DataColumn(label: Text('Action')), // ✅ New column
                        ],
                        rows: _pendingSales.asMap().entries.map((entry) {
                         int index = entry.key;
                         var sale = entry.value;
                        return DataRow(
                         cells: [
                            DataCell(Text(sale['item_name'] ?? '')),
                            DataCell(Text(sale['item_type'] ?? '')),
                            DataCell(Text(sale['customer_name'] ?? '')),
                            DataCell(Text(sale['quantity'].toString())),
                            DataCell(Text(sale['total_amount'].toString())),
                            DataCell(Text(sale['payment_status'] ?? '')),
                            DataCell(Text(sale['payment_method'] ?? '-')),
                            DataCell(
                            IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                setState(() {
                                    _totalAmount -= double.tryParse(sale['total_amount'].toString()) ?? 0.0;
                                    _pendingSales.removeAt(index);
                                });
                                },
                            ),
                            ),
                        ],
                        );
                    }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount: $_totalAmount',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                        onPressed: _generatePdf,
                        child: const Text('Generate Bill'),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}



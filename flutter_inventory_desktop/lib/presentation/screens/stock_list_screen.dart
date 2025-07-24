import 'package:flutter/material.dart';
import '../widgets/custom_nav_bar.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({Key? key}) : super(key: key);

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  final List<Map<String, dynamic>> allStock = [
    {'item': 'Inverter-body', 'type': '18KW', 'quantity': 10, 'total': 5000},
    {'item': 'Inverter-body', 'type': '20KW', 'quantity': 8, 'total': 4800},
    {'item': 'Solar Panel', 'type': '100W', 'quantity': 12, 'total': 3600},
    {'item': 'Solar Panel', 'type': '200W', 'quantity': 6, 'total': 3000},
  ];

  String? selectedItem;
  String? selectedType;
  int currentPage = 0;
  final int itemsPerPage = 2;

  List<String> get itemNames =>
      allStock.map((e) => e['item'].toString()).toSet().toList();

  List<String> get typesForSelectedItem => selectedItem == null
      ? []
      : allStock
          .where((e) => e['item'] == selectedItem)
          .map((e) => e['type'].toString())
          .toSet()
          .toList();

  List<Map<String, dynamic>> get filteredStock {
    List<Map<String, dynamic>> filtered = allStock;
    if (selectedItem != null) {
      filtered = filtered.where((e) => e['item'] == selectedItem).toList();
    }
    if (selectedType != null) {
      filtered = filtered.where((e) => e['type'] == selectedType).toList();
    }
    return filtered;
  }

  List<Map<String, dynamic>> get paginatedStock {
    int start = currentPage * itemsPerPage;
    int end = start + itemsPerPage;
    return filteredStock.sublist(start, end > filteredStock.length ? filteredStock.length : end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF55221),
        title: const Text('Stock List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// Top container with dropdowns
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildDropdown(
                      label: 'Select Item',
                      value: selectedItem,
                      items: itemNames,
                      onChanged: (val) {
                        setState(() {
                          selectedItem = val;
                          selectedType = null;
                          currentPage = 0;
                        });
                      },
                    ),
                    if (selectedItem != null)
                      _buildDropdown(
                        label: 'Select Type',
                        value: selectedType,
                        items: typesForSelectedItem,
                        onChanged: (val) {
                          setState(() {
                            selectedType = val;
                            currentPage = 0;
                          });
                        },
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.filter_list, size: 18),
                        SizedBox(width: 6),
                        Text("Filter", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Table container
            Expanded(
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Item')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Unit Price')),
                      ],
                      rows: paginatedStock.map((stock) {
                        final unitPrice =
                            (stock['total'] / stock['quantity']).toStringAsFixed(2);
                        return DataRow(cells: [
                          DataCell(Text(stock['item'])),
                          DataCell(Text(stock['type'])),
                          DataCell(Text(stock['quantity'].toString())),
                          DataCell(Text('\$$unitPrice')),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: currentPage > 0 ? () => setState(() => currentPage--) : null,
                  child: const Text("Previous"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: (currentPage + 1) * itemsPerPage < filteredStock.length
                      ? () => setState(() => currentPage++)
                      : null,
                  child: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return SizedBox(
      width: 160,
      height: 40,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
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
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

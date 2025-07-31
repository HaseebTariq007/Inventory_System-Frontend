import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/sale_history_provider.dart';

class SaleFilterUI extends StatefulWidget {
  @override
  _SaleFilterUIState createState() => _SaleFilterUIState();
}

class _SaleFilterUIState extends State<SaleFilterUI> {
  bool showSearchField = false;
  String selectedSearchOption = 'item';
  String? selectedDropdownValue;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _saleDateController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _saleDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      width: 1500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 12),
            child: const Text(
              'Sale History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Row(
            children: [
              PopupMenuButton<String>(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.filter_list),
                      SizedBox(width: 6),
                      Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                onSelected: (value) {
                  setState(() {
                    selectedSearchOption = value;
                    _searchController.clear();
                    _saleDateController.clear();
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
                        value: 'customer',
                        child: Text('Search by Customer Name'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'payment_status',
                        child: Text('Payment Status'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'sale_date',
                        child: Text('Sale Date'),
                      ),
                    ],
              ),
              const SizedBox(width: 12),
              if (showSearchField &&
                  (selectedSearchOption == 'item' ||
                      selectedSearchOption == 'customer'))
                SizedBox(
                  width: 160,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText:
                          selectedSearchOption == 'item'
                              ? 'Search by Item Name'
                              : 'Search by Customer Name',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final provider = Provider.of<SaleProvider>(
                            context,
                            listen: false,
                          );
                          if (selectedSearchOption == 'item') {
                            provider.applySearch(
                              _searchController.text,
                              searchType: 'item',
                            );
                          } else if (selectedSearchOption == 'customer') {
                            provider.applySearch(
                              _searchController.text,
                              searchType: 'customer',
                            );
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (value) {
                      final provider = Provider.of<SaleProvider>(
                        context,
                        listen: false,
                      );
                      if (selectedSearchOption == 'item') {
                        provider.applySearch(value, searchType: 'item');
                      } else if (selectedSearchOption == 'customer') {
                        provider.applySearch(value, searchType: 'customer');
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
                    Provider.of<SaleProvider>(
                      context,
                      listen: false,
                    ).applySearch(value!, searchType: 'payment_status');
                  },
                ),
              if (selectedSearchOption == 'sale_date') ...[
                SizedBox(
                  width: 160,
                  child: TextField(
                    controller: _saleDateController,
                    decoration: InputDecoration(
                      labelText: 'Enter Sale Date',
                      hintText: 'YY:MM:DD',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final value = _saleDateController.text;
                          Provider.of<SaleProvider>(
                            context,
                            listen: false,
                          ).applySearch(value, searchType: 'sale_date');
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (value) {
                      Provider.of<SaleProvider>(
                        context,
                        listen: false,
                      ).applySearch(value, searchType: 'sale_date');
                    },
                  ),
                ),
                const SizedBox(width: 12),
              ],
              if (selectedSearchOption != 'item' ||
                  selectedDropdownValue != null ||
                  _searchController.text.isNotEmpty ||
                  _saleDateController.text.isNotEmpty)
                const SizedBox(width: 24),
              ElevatedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  _saleDateController.clear();
                  selectedDropdownValue = null;
                  Provider.of<SaleProvider>(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

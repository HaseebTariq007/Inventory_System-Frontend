import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/supplier_provider.dart';
import '../widgets/supplier_form_dialog.dart';
import '../widgets/custom_nav_bar.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  final TextEditingController _searchController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshSuppliers();
  // }

  @override
  void initState() {
    super.initState();
    _refreshSuppliers();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    _refreshSuppliers(query: query.isEmpty ? null : query);
  }

  void _refreshSuppliers({String? query}) {
    Provider.of<SupplierProvider>(
      context,
      listen: false,
    ).fetchSuppliers(query: query);
  }

  void _showAddSupplierForm() {
    showDialog(
      context: context,
      builder:
          (context) => SupplierFormDialog(
            onSubmit: (name, phone, address) async {
              final provider = Provider.of<SupplierProvider>(
                context,
                listen: false,
              );
              try {
                final response = await provider.client.post(
                  Uri.parse('http://localhost:5000/api/suppliers'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'name': name,
                    'phone': phone,
                    'address': address,
                  }),
                );
                if (response.statusCode == 200) {
                  _refreshSuppliers();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to add supplier: ${response.statusCode}',
                      ),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
          ),
    );
  }

  void _showEditSupplierForm(Map<String, dynamic> supplier) {
    showDialog(
      context: context,
      builder:
          (context) => SupplierFormDialog(
            supplier: supplier,
            onSubmit: (name, phone, address) async {
              final provider = Provider.of<SupplierProvider>(
                context,
                listen: false,
              );
              try {
                final response = await provider.client.put(
                  Uri.parse(
                    'http://localhost:5000/api/suppliers/${supplier['supplier_id']}',
                  ),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({
                    'name': name,
                    'phone': phone,
                    'address': address,
                  }),
                );
                if (response.statusCode == 200) {
                  _refreshSuppliers();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to update supplier: ${response.statusCode}',
                      ),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
          ),
    );
  }

  void _goToPreviousPage() {
    final provider = Provider.of<SupplierProvider>(context, listen: false);
    if (provider.currentPage > 1) {
      provider.previousPage();
    }
  }

  void _showDeleteConfirmation(BuildContext context, String supplierId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text(
              'Are you sure you want to delete this supplier?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<SupplierProvider>(
                    context,
                    listen: false,
                  ).deleteSupplier(supplierId);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Supplier'),
      body: Consumer<SupplierProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
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
                      'Supplier',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by name',
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _showAddSupplierForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF55221),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add Supplier +',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Replace this part inside your build method
              Expanded(
                child:
                    provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : provider.error != null
                        ? Center(child: Text(provider.error!))
                        : provider.suppliers.isEmpty
                        ? const Center(child: Text('No suppliers found'))
                        : Center(
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
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                    vertical: 12.0,
                                  ),
                                  color: Colors.grey.shade200,
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Supplier Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Phone',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Address',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Actions',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(height: 0, thickness: 1),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: provider.suppliers.length,
                                    itemBuilder: (context, index) {
                                      final supplier =
                                          provider.suppliers[index];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 18.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    supplier['name'] ?? '',
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    supplier['phone'] ?? '',
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    supplier['address'] ?? '',
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color: Colors.blue,
                                                          ),
                                                          onPressed:
                                                              () =>
                                                                  _showEditSupplierForm(
                                                                    supplier,
                                                                  ),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed:
                                                              () => _showDeleteConfirmation(
                                                                context,
                                                                supplier['id'],
                                                              ),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(height: 0),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
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
                          value: provider.limit,
                          items: const [
                            DropdownMenuItem(value: 10, child: Text('10')),
                            DropdownMenuItem(value: 25, child: Text('25')),
                            DropdownMenuItem(value: 50, child: Text('50')),
                          ],
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              Provider.of<SupplierProvider>(
                                context,
                                listen: false,
                              ).changeLimit(newValue);
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        if (provider.currentPage > 1)
                          ElevatedButton(
                            onPressed: () {
                              final query = _searchController.text.trim();
                              provider.previousPage(
                                query: query.isEmpty ? null : query,
                              );
                            },
                            // onPressed: _goToPreviousPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF55221),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Previous'),
                          ),
                      ],
                    ),
                    Text('Page ${provider.currentPage}'),
                    ElevatedButton(
                      onPressed: () {
                        final query = _searchController.text.trim();
                        provider.nextPage(query: query.isEmpty ? null : query);
                      },
                      // onPressed: provider.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF55221),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

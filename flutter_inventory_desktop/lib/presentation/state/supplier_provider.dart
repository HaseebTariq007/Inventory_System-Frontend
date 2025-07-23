// lib/presentation/state/supplier_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SupplierProvider with ChangeNotifier {
  List<dynamic> _suppliers = [];
  bool _isLoading = false;
  String? _error;
  final http.Client client = http.Client();
  int _limit = 10; // Default limit set to 10
  int _currentPage = 1;

  List<dynamic> get suppliers => _suppliers;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get limit => _limit;
  int get currentPage => _currentPage; // New: Expose _currentPage as a getter

  // Future<void> fetchSuppliers() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final response = await client.get(
  //       Uri.parse(
  //         'http://localhost:5000/api/suppliers?page=$_currentPage&limit=$_limit',
  //       ),
  //     );
  //     print(
  //       'Raw response body: ${response.body}',
  //     ); // Log raw response for debugging
  //     final data = jsonDecode(response.body) as Map<String, dynamic>;
  //     if (response.statusCode == 200) {
  //       final nestedData = data['data'] as Map<String, dynamic>?;
  //       if (nestedData != null &&
  //           nestedData.containsKey('data') &&
  //           nestedData['data'] is List) {
  //         _suppliers = nestedData['data'] as List<dynamic>;
  //         print('Fetched suppliers: $_suppliers'); // Debug log
  //       } else {
  //         _error =
  //             'Invalid response format: nested "data" is not a list or missing';
  //         print('Invalid nested data: $nestedData');
  //       }
  //     } else {
  //       _error =
  //           'Failed to load suppliers: ${response.statusCode} - ${response.body}';
  //       print(
  //         'Failed with status: ${response.statusCode}, body: ${response.body}',
  //       );
  //     }
  //   } catch (e) {
  //     _error = 'Error: $e';
  //     print('Error: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchSuppliers({String? query}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final uri = Uri.parse('http://localhost:5000/api/suppliers').replace(
        queryParameters: {
          'page': _currentPage.toString(),
          'limit': _limit.toString(),
          if (query != null && query.isNotEmpty) 'search': query,
        },
      );

      final response = await client.get(uri);
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final nestedData = data['data'] as Map<String, dynamic>?;
        if (nestedData != null &&
            nestedData.containsKey('data') &&
            nestedData['data'] is List) {
          _suppliers = nestedData['data'] as List<dynamic>;
        } else {
          _error =
              'Invalid response format: nested "data" is not a list or missing';
        }
      } else {
        _error =
            'Failed to load suppliers: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeLimit(int newLimit) {
    _limit = newLimit;
    _currentPage = 1; // Reset to first page on limit change
    fetchSuppliers();
  }

  // void nextPage() {
  //   _currentPage++;
  //   fetchSuppliers();
  // }

  // // Updated: Use setPage for Previous button
  // void previousPage() {
  //   if (_currentPage > 1) {
  //     _currentPage--;
  //     fetchSuppliers();
  //   }
  // }

  void nextPage({String? query}) {
    _currentPage++;
    fetchSuppliers(query: query);
  }

  void previousPage({String? query}) {
    if (_currentPage > 1) {
      _currentPage--;
      fetchSuppliers(query: query);
    }
  }

  Future<void> deleteSupplier(String supplierId) async {
    try {
      final response = await client.delete(
        Uri.parse('http://localhost:5000/api/suppliers/$supplierId'),
      );
      if (response.statusCode == 200) {
        await fetchSuppliers(); // Refresh dynamically after deletion
      } else {
        _error = 'Failed to delete supplier';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
}

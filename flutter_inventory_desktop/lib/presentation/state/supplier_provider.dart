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
  int _totalPages = 1; // Add total pages metadata

  List<dynamic> get suppliers => _suppliers;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get limit => _limit;
  int get currentPage => _currentPage; // Expose _currentPage as a getter
  int get totalPages => _totalPages; // Expose total pages

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
          // Update total pages from backend response
          _totalPages = nestedData['pages'] ?? 1;
        } else {
          _error =
              'Invalid response format: nested "data" is not a list or missing';
          _suppliers = [];
          _totalPages = 1;
        }
      } else {
        _error =
            'Failed to load suppliers: ${response.statusCode} - ${response.body}';
        _suppliers = [];
        _totalPages = 1;
      }
    } catch (e) {
      _error = 'Error: $e';
      _suppliers = [];
      _totalPages = 1;
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

  void nextPage({String? query}) {
    if (_currentPage < _totalPages) {
      _currentPage++;
      fetchSuppliers(query: query);
    }
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

  void clearSearch() {
    _currentPage = 1;
    fetchSuppliers(); // Fetch without query to clear search
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
}

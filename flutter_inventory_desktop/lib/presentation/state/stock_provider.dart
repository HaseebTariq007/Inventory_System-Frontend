import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockProvider with ChangeNotifier {
  final http.Client client = http.Client();

  List<Map<String, dynamic>> _stocks = [];
  bool _isLoading = false;
  String? _error;

  int _currentPage = 1;
  int _limit = 10;

  String? _selectedItem;
  String? _selectedType;

  List<Map<String, dynamic>> get stocks => _stocks;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get limit => _limit;
  String? get selectedItem => _selectedItem;
  String? get selectedType => _selectedType;

  /// Fetch paginated stock data from backend
  Future<void> fetchStockData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final queryParams = {
        'page': '$_currentPage',
        'limit': '$_limit',
        if (_selectedItem != null) 'item': _selectedItem!,
        if (_selectedType != null) 'type': _selectedType!,
      };

      final uri = Uri.http('localhost:5000', '/api/stock', queryParams);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _stocks = List<Map<String, dynamic>>.from(data['data']);
      } else {
        _error = 'Failed to load stock data: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Pagination: Go to next page
  void nextPage() {
    _currentPage++;
    fetchStockData();
  }

  /// Pagination: Go to previous page
  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchStockData();
    }
  }

  /// Change the number of records per page
  void changeLimit(int newLimit) {
    _limit = newLimit;
    _currentPage = 1;
    fetchStockData();
  }

  /// Reset to first page
  void resetPage() {
    _currentPage = 1;
    fetchStockData();
  }

  /// Apply filters and refresh data
  void applyFilters({String? item, String? type}) {
    _selectedItem = item;
    _selectedType = type;
    _currentPage = 1;
    fetchStockData();
  }

  /// Clear all filters
  void clearFilters() {
    _selectedItem = null;
    _selectedType = null;
    _currentPage = 1;
    fetchStockData();
  }
}

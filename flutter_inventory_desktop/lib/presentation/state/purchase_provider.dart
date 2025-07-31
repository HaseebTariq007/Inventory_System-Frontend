// new code with next pagination disabled

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import '../services/api_service.dart';

class PurchaseProvider with ChangeNotifier {
  final http.Client client = http.Client();

  List<Map<String, dynamic>> _purchases = [];
  bool _isLoading = false;
  String? _error;
  String? _searchItem;
  String? _searchSupplier;
  String? _paymentStatus;
  String? _purchaseDate;

  String? get searchItem => _searchItem;
  String? get searchSupplier => _searchSupplier;
  String? get paymentStatus => _paymentStatus;
  String? get purchaseDate => _purchaseDate;

  int _currentPage = 1;
  int _limit = 10;
  int _totalPages = 1; // Add total pages metadata

  String? get error => _error;
  int get currentPage => _currentPage;
  int get limit => _limit;
  int get totalPages => _totalPages; // Expose total pages
  List<Map<String, dynamic>> get purchases => _purchases;
  bool get isLoading => _isLoading;

  final String _baseUrl = 'http://localhost:5000/api';

  bool _isValidDate(String date) {
    try {
      final parts = date.split(':');
      if (parts.length != 3) return false;
      int.parse(parts[0]); // YY
      int.parse(parts[1]); // MM
      int.parse(parts[2]); // DD
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> fetchPurchases() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final queryParams = {
        'page': '$_currentPage',
        'limit': '$_limit',
        if (_searchItem != null && _searchItem!.isNotEmpty)
          'item': _searchItem!,
        if (_searchSupplier != null && _searchSupplier!.isNotEmpty)
          'supplier': _searchSupplier!,
        if (_paymentStatus != null && _paymentStatus!.isNotEmpty)
          'payment_status': _paymentStatus!,
        if (_purchaseDate != null &&
            _purchaseDate!.isNotEmpty &&
            _isValidDate(_purchaseDate!))
          'purchase_date': _purchaseDate!,
      };

      final uri = Uri.parse(
        '$_baseUrl/purchases',
      ).replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          if (data['data']['data'] is List) {
            _purchases = List<Map<String, dynamic>>.from(data['data']['data']);
          } else {
            _purchases = [];
          }
          // Update total pages from backend response
          _totalPages = data['data']['pages'] ?? 1;
        } else {
          _purchases = [];
          _totalPages = 1;
        }
      } else {
        _error = 'Failed to load purchases: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void applySearch(String? query, {String searchType = 'item'}) {
    _searchItem = null;
    _searchSupplier = null;
    _paymentStatus = null;
    _purchaseDate = null;

    if (searchType == 'item') {
      _searchItem = query;
    } else if (searchType == 'supplier') {
      _searchSupplier = query;
    } else if (searchType == 'payment_status') {
      _paymentStatus = query;
    } else if (searchType == 'purchase_date') {
      _purchaseDate = query;
    }
    _currentPage = 1;
    fetchPurchases();
  }

  void clearSearch() {
    _searchItem = null;
    _searchSupplier = null;
    _paymentStatus = null;
    _purchaseDate = null;
    _currentPage = 1;
    fetchPurchases();
  }

  void nextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      fetchPurchases();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchPurchases();
    }
  }

  void changeLimit(int newLimit) {
    _limit = newLimit;
    _currentPage = 1;
    fetchPurchases();
  }

  void resetPage() {
    _currentPage = 1;
    fetchPurchases();
  }

  Future<void> submitPurchase(Map<String, dynamic> data) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/purchases'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        fetchPurchases();
      } else {
        _error = 'Failed to submit purchase: ${response.statusCode}';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
    }
  }
}

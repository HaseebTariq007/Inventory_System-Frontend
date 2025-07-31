import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SaleProvider with ChangeNotifier {
  final http.Client client = http.Client();

  List<Map<String, dynamic>> _sales = [];
  bool _isLoading = false;
  String? _error;
  String? _searchItem;
  String? _searchCustomer;
  String? _paymentStatus;
  String? _saleDate;

  int _currentPage = 1;
  int _limit = 10;
  int _totalPages = 1; // Add total pages metadata

  String? get searchItem => _searchItem;
  String? get searchCustomer => _searchCustomer;
  String? get paymentStatus => _paymentStatus;
  String? get saleDate => _saleDate;

  List<Map<String, dynamic>> get sales => _sales;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get limit => _limit;
  int get totalPages => _totalPages; // Expose total pages

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

  Future<void> fetchSales() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final queryParams = {
        'page': '$_currentPage',
        'limit': '$_limit',
        if (_searchItem != null && _searchItem!.isNotEmpty)
          'item': _searchItem!,
        if (_searchCustomer != null && _searchCustomer!.isNotEmpty)
          'customer': _searchCustomer!,
        if (_paymentStatus != null && _paymentStatus!.isNotEmpty)
          'payment_status': _paymentStatus!,
        if (_saleDate != null &&
            _saleDate!.isNotEmpty &&
            _isValidDate(_saleDate!))
          'sale_date': _saleDate!,
      };

      final uri = Uri.parse(
        '$_baseUrl/sales',
      ).replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          if (data['data']['data'] is List) {
            _sales = List<Map<String, dynamic>>.from(data['data']['data']);
          } else {
            _sales = [];
          }
          // Update total pages from backend response
          _totalPages = data['data']['pages'] ?? 1;
        } else {
          _sales = [];
          _totalPages = 1;
        }
      } else {
        _error = 'Failed to load sales: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void applySearch(String? query, {String searchType = 'item'}) {
    _searchItem = null;
    _searchCustomer = null;
    _paymentStatus = null;
    _saleDate = null;

    if (searchType == 'item') {
      _searchItem = query;
    } else if (searchType == 'customer') {
      _searchCustomer = query;
    } else if (searchType == 'payment_status') {
      _paymentStatus = query;
    } else if (searchType == 'sale_date') {
      _saleDate = query;
    }
    _currentPage = 1;
    fetchSales();
  }

  void clearSearch() {
    _searchItem = null;
    _searchCustomer = null;
    _paymentStatus = null;
    _saleDate = null;
    _currentPage = 1;
    fetchSales();
  }

  void nextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      fetchSales();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchSales();
    }
  }

  void changeLimit(int newLimit) {
    _limit = newLimit;
    _currentPage = 1;
    fetchSales();
  }

  void resetPage() {
    _currentPage = 1;
    fetchSales();
  }

  Future<void> refreshSales() async {
    await fetchSales();
  }

  Future<void> updateSaleStatus(
    String saleId,
    String paymentMethod, {
    String? bankAccount,
  }) async {
    try {
      final response = await client.put(
        Uri.parse('$_baseUrl/sales/$saleId/status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'payment_status': 'PAID',
          'payment_method': paymentMethod,
          if (paymentMethod.toUpperCase() == 'BANK' && bankAccount != null)
            'bank_account': bankAccount,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'sale status updated successfully') {
          await fetchSales(); // Refresh sales after successful update
        } else {
          _error = 'Unexpected response: ${data['message'] ?? 'Unknown error'}';
          notifyListeners();
        }
      } else {
        _error =
            'Failed to update sale status: ${response.statusCode} - ${jsonDecode(response.body)['message'] ?? 'Unknown error'}';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
    }
  }
}

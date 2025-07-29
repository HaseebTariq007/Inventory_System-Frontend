import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComponentSaleProvider with ChangeNotifier {
  final http.Client client = http.Client();

  final String _baseUrl = 'http://localhost:5000/api';

  List<Map<String, dynamic>> _sales = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get sales => _sales;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Submit sale data to the backend
  Future<void> createSale(Map<String, dynamic> data) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/sales'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // You can call fetchSales() here if implemented
      } else {
        _error = 'Failed to submit sale: ${response.statusCode}';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
    }
  }
}

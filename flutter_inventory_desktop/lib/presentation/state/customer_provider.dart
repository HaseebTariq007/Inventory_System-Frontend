// lib/presentation/state/customer_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerProvider with ChangeNotifier {
  List<dynamic> _customers = [];
  bool _isLoading = false;
  String? _error;
  final http.Client client = http.Client();
  int _limit = 10;
  int _currentPage = 1;

  List<dynamic> get customers => _customers;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get limit => _limit;
  int get currentPage => _currentPage;

  // set _currentPage(int _currentPage) {}
  void resetPage() {
    _currentPage = 1;
  }

  // Future<void> fetchCustomers() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final response = await client.get(
  //       Uri.parse(
  //         'http://localhost:5000/api/customers?page=$_currentPage&limit=$_limit',
  //       ),
  //     );
  //     print('Raw response body: ${response.body}');
  //     final data = jsonDecode(response.body) as Map<String, dynamic>;

  //     if (response.statusCode == 200) {
  //       final nestedData = data['data'] as Map<String, dynamic>?;
  //       if (nestedData != null &&
  //           nestedData.containsKey('data') &&
  //           nestedData['data'] is List) {
  //         _customers = nestedData['data'] as List<dynamic>;
  //         print('Fetched customers: $_customers');
  //       } else {
  //         _error =
  //             'Invalid response format: nested "data" is not a list or missing';
  //         print('Invalid nested data: $nestedData');
  //       }
  //     } else {
  //       _error =
  //           'Failed to load customers: ${response.statusCode} - ${response.body}';
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
  Future<void> fetchCustomers({String? query}) async {
    _isLoading = true;
    _error = null;

    // Reset page if new search
    if (query != null && query.isNotEmpty) {
      _currentPage = 1;
    }

    notifyListeners();

    try {
      final uri = Uri.parse(
        'http://localhost:5000/api/customers?page=$_currentPage&limit=$_limit${query != null ? '&search=$query' : ''}',
      );
      final response = await client.get(uri);

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final nestedData = data['data'] as Map<String, dynamic>?;
        if (nestedData != null &&
            nestedData.containsKey('data') &&
            nestedData['data'] is List) {
          _customers = nestedData['data'] as List<dynamic>;
        } else {
          _error =
              'Invalid response format: nested "data" is not a list or missing';
        }
      } else {
        _error =
            'Failed to load customers: ${response.statusCode} - ${response.body}';
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
    _currentPage = 1;
    fetchCustomers();
  }

  void nextPage() {
    _currentPage++;
    fetchCustomers();
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchCustomers();
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      final response = await client.delete(
        Uri.parse('http://localhost:5000/api/customers/$customerId'),
      );
      if (response.statusCode == 200) {
        await fetchCustomers();
      } else {
        _error = 'Failed to delete customer';
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

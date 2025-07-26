// //

// //New Code

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../models/purchase.dart';

// class PurchaseProvider with ChangeNotifier {
//   final http.Client client = http.Client();

//   List<Purchase> _purchases = [];
//   bool _isLoading = false;
//   String? _error;

//   int _currentPage = 1;
//   int _limit = 10;

//   List<Purchase> get purchases => _purchases;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get currentPage => _currentPage;
//   int get limit => _limit;

//   Future<void> fetchPurchases() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final response = await client.get(
//         Uri.parse(
//           'http://localhost:5000/api/purchases?page=$_currentPage&limit=$_limit',
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _purchases = (data['data'] as List)
//             .map((json) => Purchase.fromJson(json))
//             .toList();
//       } else {
//         _error = 'Failed to load purchases: ${response.statusCode}';
//       }
//     } catch (e) {
//       _error = 'Error: $e';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   void nextPage() {
//     _currentPage++;
//     fetchPurchases();
//   }

//   void previousPage() {
//     if (_currentPage > 1) {
//       _currentPage--;
//       fetchPurchases();
//     }
//   }

//   void changeLimit(int newLimit) {
//     _limit = newLimit;
//     _currentPage = 1;
//     fetchPurchases();
//   }

//   void resetPage() {
//     _currentPage = 1;
//     fetchPurchases();
//   }

//   Future<void> deletePurchase(int id) async {
//     try {
//       final response = await client.delete(
//         Uri.parse('http://localhost:5000/api/purchases/$id'),
//       );
//       if (response.statusCode == 200) {
//         fetchPurchases();
//       } else {
//         _error = 'Failed to delete purchase: ${response.statusCode}';
//         notifyListeners();
//       }
//     } catch (e) {
//       _error = 'Error: $e';
//       notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     client.close();
//     super.dispose();
//   }
// }

//New Code

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PurchaseProvider with ChangeNotifier {
  final http.Client client = http.Client();

  List<Map<String, dynamic>> _purchases = [];
  bool _isLoading = false;
  String? _error;

  int _currentPage = 1;
  int _limit = 10;

  List<Map<String, dynamic>> get purchases => _purchases;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get limit => _limit;

  final String _baseUrl = 'http://localhost:5000/api';

  // haseeb
  Future<void> fetchPurchases() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/purchases?page=$_currentPage&limit=$_limit'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['data'] is List) {
          _purchases = List<Map<String, dynamic>>.from(
            data['data']['data'] ?? [],
          );
        } else {
          _purchases = []; // Fallback to empty list if data is invalid
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

  void nextPage() {
    _currentPage++;
    fetchPurchases();
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

  Future<void> deletePurchase(int id) async {
    try {
      final response = await client.delete(
        Uri.parse('$_baseUrl/purchases/$id'),
      );
      if (response.statusCode == 200) {
        fetchPurchases();
      } else {
        _error = 'Failed to delete: ${response.statusCode}';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
    }
  }

  Future<void> submitPurchase(Map<String, dynamic> data) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/purchases'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        fetchPurchases(); // Refresh data after successful insert
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

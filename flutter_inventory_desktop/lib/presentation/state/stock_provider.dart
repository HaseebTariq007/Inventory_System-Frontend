// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StockProvider with ChangeNotifier {
//   final http.Client client = http.Client();

//   List<Map<String, dynamic>> _stocks = [];
//   bool _isLoading = false;
//   String? _error;

//   int _currentPage = 1;
//   int _limit = 10;

//   String? _selectedItem;
//   String? _selectedType;

//   List<Map<String, dynamic>> get stocks => _stocks;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get currentPage => _currentPage;
//   int get limit => _limit;
//   String? get selectedItem => _selectedItem;
//   String? get selectedType => _selectedType;

//   /// Fetch paginated stock data from backend
//   Future<void> fetchStockData() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final queryParams = {
//         'page': '$_currentPage',
//         'limit': '$_limit',
//         if (_selectedItem != null) 'item': _selectedItem!,
//         if (_selectedType != null) 'type': _selectedType!,
//       };

//       final uri = Uri.http('localhost:5000', '/api/stocks', queryParams);
//       final response = await client.get(uri);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _stocks = List<Map<String, dynamic>>.from(data['data']);
//       } else {
//         _error = 'Failed to load stock data: ${response.statusCode}';
//       }
//     } catch (e) {
//       _error = 'Error: $e';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   /// Pagination: Go to next page
//   void nextPage() {
//     _currentPage++;
//     fetchStockData();
//   }

//   /// Pagination: Go to previous page
//   void previousPage() {
//     if (_currentPage > 1) {
//       _currentPage--;
//       fetchStockData();
//     }
//   }

//   /// Change the number of records per page
//   void changeLimit(int newLimit) {
//     _limit = newLimit;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   /// Reset to first page
//   void resetPage() {
//     _currentPage = 1;
//     fetchStockData();
//   }

//   /// Apply filters and refresh data
//   void applyFilters({String? item, String? type}) {
//     _selectedItem = item;
//     _selectedType = type;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   /// Clear all filters
//   void clearFilters() {
//     _selectedItem = null;
//     _selectedType = null;
//     _currentPage = 1;
//     fetchStockData();
//   }
// }

// haseeeb code

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StockProvider with ChangeNotifier {
//   final http.Client client = http.Client();

//   List<Map<String, dynamic>> _stocks = [];
//   bool _isLoading = false;
//   String? _error;

//   int _currentPage = 1;
//   int _limit = 10;

//   String? _selectedItem;
//   String? _selectedType;

//   List<Map<String, dynamic>> get stocks => _stocks;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get currentPage => _currentPage;
//   int get limit => _limit;
//   String? get selectedItem => _selectedItem;
//   String? get selectedType => _selectedType;

//   /// Fetch paginated stock data from backend
//   Future<void> fetchStockData() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final queryParams = {
//         'page': '$_currentPage',
//         'limit': '$_limit',
//         if (_selectedItem != null) 'item': _selectedItem!,
//         if (_selectedType != null) 'type': _selectedType!,
//       };

//       final uri = Uri.http('localhost:5000', '/api/stocks', queryParams);
//       final response = await client.get(uri);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Handle nested response format
//         if (data is Map &&
//             data['data'] is Map &&
//             data['data']['data'] is List) {
//           _stocks = List<Map<String, dynamic>>.from(data['data']['data']);
//         } else {
//           _stocks = [];
//           _error = 'Invalid data format from server';
//         }
//       } else {
//         _error = 'Failed to load stock data: ${response.statusCode}';
//       }
//     } catch (e) {
//       _error = 'Error: $e';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   void nextPage() {
//     _currentPage++;
//     fetchStockData();
//   }

//   void previousPage() {
//     if (_currentPage > 1) {
//       _currentPage--;
//       fetchStockData();
//     }
//   }

//   void changeLimit(int newLimit) {
//     _limit = newLimit;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void resetPage() {
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void applyFilters({String? item, String? type}) {
//     _selectedItem = item;
//     _selectedType = type;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void clearFilters() {
//     _selectedItem = null;
//     _selectedType = null;
//     _currentPage = 1;
//     fetchStockData();
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StockProvider with ChangeNotifier {
//   final http.Client client = http.Client();

//   List<Map<String, dynamic>> _stocks = [];
//   bool _isLoading = false;
//   String? _error;

//   int _currentPage = 1;
//   int _limit = 10;

//   String? _selectedItem;
//   String? _selectedType;

//   List<Map<String, dynamic>> get stocks => _stocks;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get currentPage => _currentPage;
//   int get limit => _limit;
//   String? get selectedItem => _selectedItem;
//   String? get selectedType => _selectedType;

//   /// Fetch paginated stock data from backend
//   Future<void> fetchStockData() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final queryParams = {
//         'page': '$_currentPage',
//         'limit': '$_limit',
//         if (_selectedItem != null) 'item': _selectedItem!,
//         if (_selectedType != null) 'type': _selectedType!,
//       };

//       final uri = Uri.http('localhost:5000', '/api/stocks', queryParams);
//       final response = await client.get(uri);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Handle nested response format and append new data
//         if (data is Map &&
//             data['data'] is Map &&
//             data['data']['data'] is List) {
//           final newStocks = List<Map<String, dynamic>>.from(
//             data['data']['data'],
//           );
//           if (_currentPage == 1) {
//             _stocks = newStocks; // Replace for first page
//           } else {
//             _stocks.addAll(newStocks); // Append for subsequent pages
//           }
//         } else {
//           _stocks = [];
//           _error = 'Invalid data format from server';
//         }
//       } else {
//         _error = 'Failed to load stock data: ${response.statusCode}';
//       }
//     } catch (e) {
//       _error = 'Error: $e';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   void nextPage() async {
//     _currentPage++;
//     await fetchStockData();
//     if (_stocks.length < _currentPage * _limit) {
//       _currentPage--; // Revert if no more data
//     }
//     notifyListeners();
//   }

//   void previousPage() {
//     if (_currentPage > 1) {
//       _currentPage--;
//       fetchStockData();
//     }
//   }

//   void changeLimit(int newLimit) {
//     _limit = newLimit;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void resetPage() {
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void applyFilters({String? item, String? type}) {
//     _selectedItem = item;
//     _selectedType = type;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void clearFilters() {
//     _selectedItem = null;
//     _selectedType = null;
//     _currentPage = 1;
//     fetchStockData();
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StockProvider with ChangeNotifier {
//   final http.Client client = http.Client();

//   List<Map<String, dynamic>> _stocks = [];
//   bool _isLoading = false;
//   String? _error;

//   int _currentPage = 1;
//   int _limit = 10;

//   String? _selectedItem;
//   String? _selectedType;

//   List<Map<String, dynamic>> get stocks => _stocks;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get currentPage => _currentPage;
//   int get limit => _limit;
//   String? get selectedItem => _selectedItem;
//   String? get selectedType => _selectedType;

//   /// Fetch paginated stock data from backend
//   Future<void> fetchStockData() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final queryParams = {
//         'page': '$_currentPage',
//         'limit': '$_limit',
//         if (_selectedItem != null) 'item': _selectedItem!,
//         if (_selectedType != null) 'type': _selectedType!,
//       };

//       final uri = Uri.http('localhost:5000', '/api/stocks', queryParams);
//       final response = await client.get(uri);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Handle nested response format and append new data
//         if (data is Map &&
//             data['data'] is Map &&
//             data['data']['data'] is List) {
//           final newStocks = List<Map<String, dynamic>>.from(
//             data['data']['data'],
//           );
//           if (_currentPage == 1) {
//             _stocks = newStocks; // Replace for first page
//           } else {
//             _stocks.addAll(newStocks); // Append for subsequent pages
//           }
//         } else {
//           _stocks = [];
//           _error = 'Invalid data format from server';
//         }
//       } else {
//         _error = 'Failed to load stock data: ${response.statusCode}';
//       }
//     } catch (e) {
//       _error = 'Error: $e';
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   void nextPage() async {
//     _currentPage++;
//     await fetchStockData();
//     if (_stocks.length < _currentPage * _limit) {
//       _currentPage--; // Revert if no more data
//     }
//     notifyListeners();
//   }

//   void previousPage() {
//     if (_currentPage > 1) {
//       _currentPage--;
//       fetchStockData();
//     }
//   }

//   void changeLimit(int newLimit) {
//     _limit = newLimit;
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void resetPage() {
//     _currentPage = 1;
//     fetchStockData();
//   }

//   void applyFilters({String? item, String? type}) {
//     _selectedItem = item;
//     _selectedType = type;
//     _currentPage = 1; // Reset to first page when applying filters
//     fetchStockData();
//   }

//   void clearFilters() {
//     _selectedItem = null;
//     _selectedType = null;
//     _currentPage = 1; // Reset to first page when clearing filters
//     fetchStockData();
//   }
// }

import 'dart:async';
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

  // Sets to store all unique items and types across all pages
  final Set<String> _allItemNames = {};
  final Map<String, Set<String>> _itemTypesMap = {}; // Map item to its types

  List<Map<String, dynamic>> get stocks => _stocks;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get limit => _limit;
  String? get selectedItem => _selectedItem;
  String? get selectedType => _selectedType;
  List<String> get allItemNames => _allItemNames.toList();
  List<String> get allItemTypes =>
      _itemTypesMap.values.expand((types) => types).toList();

  List<String> getTypesForItem(String item) =>
      _itemTypesMap[item]?.toList() ?? [];

  /// Fetch paginated stock data from backend
  Future<void> fetchStockData({String? query}) async {
    _isLoading = true;
    _error = null;

    // Reset page if new search
    if (query != null && query.isNotEmpty) {
      _currentPage = 1;
      _stocks = []; // Clear previous results for new search
    }

    notifyListeners();

    try {
      final queryParams = {
        'page': '$_currentPage',
        'limit': '$_limit',
        if (query != null) 'search': query, // Match backend 'search' parameter
      };

      final uri = Uri.http('localhost:5000', '/api/stocks', queryParams);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map &&
            data['data'] is Map &&
            data['data']['data'] is List) {
          _stocks = List<Map<String, dynamic>>.from(
            data['data']['data'],
          ); // Replace with new data
          // Update all item names and types
          for (var stock in _stocks) {
            final itemName = stock['item']?['name'] as String?;
            final itemType = stock['item']?['type'] as String?;
            if (itemName != null) {
              _allItemNames.add(itemName);
              if (itemType != null) {
                _itemTypesMap.putIfAbsent(itemName, () => {}).add(itemType);
              }
            }
          }
        } else {
          _stocks = [];
          _error = 'Invalid data format from server';
        }
      } else {
        _error = 'Failed to load stock data: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextPage() {
    _currentPage++;
    fetchStockData();
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      fetchStockData();
    }
  }

  void changeLimit(int newLimit) {
    _limit = newLimit;
    _currentPage = 1;
    fetchStockData();
  }

  void resetPage() {
    _currentPage = 1;
    fetchStockData();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }
}

// Debouncer class to limit API calls
class Debouncer {
  final int milliseconds;
  VoidCallback? _action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _action = action;
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      if (_action != null) {
        _action!();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}

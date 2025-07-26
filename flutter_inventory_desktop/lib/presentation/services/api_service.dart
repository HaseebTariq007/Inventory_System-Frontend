// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/item.dart';
// import '../models/supplier.dart';
// import '../models/purchase.dart';

// class ApiService {
//   static const baseUrl = 'http://localhost:5000/api'; // Updated to include /api

//   // Fetch items
//   static Future<List<Item>> fetchItems() async {
//     final response = await http.get(Uri.parse('$baseUrl/items'));
//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return data.map((json) => Item.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load items');
//     }
//   }

//   // Fetch suppliers
//   static Future<List<Supplier>> fetchSuppliers() async {
//     final response = await http.get(Uri.parse('$baseUrl/suppliers'));
//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return data.map((json) => Supplier.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load suppliers');
//     }
//   }

//   // Submit a new purchase
//   static Future<void> submitPurchase(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/purchases'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );

//     if (response.statusCode != 201 && response.statusCode != 200) {
//       throw Exception('Failed to create purchase: ${response.body}');
//     }
//   }

//   // Fetch paginated purchases
//   static Future<List<Purchase>> fetchPurchases({int page = 1, int limit = 10}) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/purchases?page=$page&limit=$limit'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       // Assuming paginated format: { data: [...], total: int }
//       final List rawList = data['data'] ?? data;

//       return rawList.map((json) => Purchase.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch purchases');
//     }
//   }

//   // Update an existing purchase
//   static Future<void> updatePurchase(int purchaseId, Map<String, dynamic> data) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/purchases/$purchaseId'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to update purchase');
//     }
//   }

//   // Delete a purchase
//   static Future<void> deletePurchase(int purchaseId) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/purchases/$purchaseId'),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete purchase');
//     }
//   }
// }

//New Code
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const baseUrl = 'http://localhost:5000/api';

//   // Fetch items as List<Map<String, dynamic>>
//   static Future<List<Map<String, dynamic>>> fetchItems() async {
//     final response = await http.get(Uri.parse('$baseUrl/items'));
//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return List<Map<String, dynamic>>.from(data);
//     } else {
//       throw Exception('Failed to load items');
//     }
//   }

//   // Fetch suppliers
//   static Future<List<Map<String, dynamic>>> fetchSuppliers() async {
//     final response = await http.get(Uri.parse('$baseUrl/suppliers'));
//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return List<Map<String, dynamic>>.from(data);
//     } else {
//       throw Exception('Failed to load suppliers');
//     }
//   }

//   // Submit a new purchase
//   static Future<void> submitPurchase(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/purchases'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );

//     if (response.statusCode != 201 && response.statusCode != 200) {
//       throw Exception('Failed to create purchase: ${response.body}');
//     }
//   }

//   // Fetch paginated purchases
//   static Future<List<Map<String, dynamic>>> fetchPurchases({int page = 1, int limit = 10}) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/purchases?page=$page&limit=$limit'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List rawList = data['data'] ?? data;
//       return List<Map<String, dynamic>>.from(rawList);
//     } else {
//       throw Exception('Failed to fetch purchases');
//     }
//   }

//   // Update a purchase
//   static Future<void> updatePurchase(int purchaseId, Map<String, dynamic> data) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/purchases/$purchaseId'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to update purchase');
//     }
//   }

//   // Delete a purchase
//   static Future<void> deletePurchase(int purchaseId) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/purchases/$purchaseId'),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete purchase');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://localhost:5000/api';

  // Fetch items as List<Map<String, dynamic>>
  static Future<List<Map<String, dynamic>>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/items'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchSuppliers() async {
    final List<Map<String, dynamic>> allSuppliers = [];
    int page = 1;
    const int limit = 10; // Match backend's per_page default

    while (true) {
      final response = await http.get(
        Uri.parse('$baseUrl/suppliers?page=$page&limit=$limit'),
      );
      print('Raw response from /suppliers (page $page): ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map &&
            data.containsKey('data') &&
            data['data'] is Map &&
            data['data'].containsKey('data')) {
          final pageData = data['data']['data'] as List<dynamic>? ?? [];
          allSuppliers.addAll(pageData.cast<Map<String, dynamic>>());
          final totalPages = data['data']['pages'] as int? ?? 1;
          if (page >= totalPages) break;
          page++;
        } else {
          throw Exception('Unexpected response format: $data');
        }
      } else {
        throw Exception(
          'Failed to load suppliers: ${response.statusCode} - ${response.body}',
        );
      }
    }
    return allSuppliers;
  }

  // Submit a new purchase
  static Future<void> submitPurchase(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/purchases'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to create purchase: ${response.body}');
    }
  }

  // Fetch paginated purchases
  static Future<List<Map<String, dynamic>>> fetchPurchases({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/purchases?page=$page&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List rawList = data['data'] ?? data;
      return List<Map<String, dynamic>>.from(rawList);
    } else {
      throw Exception('Failed to fetch purchases');
    }
  }

  // Update a purchase
  static Future<void> updatePurchase(
    int purchaseId,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/purchases/$purchaseId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update purchase');
    }
  }

  // Delete a purchase
  static Future<void> deletePurchase(int purchaseId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/purchases/$purchaseId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete purchase');
    }
  }

  //Fetch stock data
  static Future<List<Map<String, dynamic>>> fetchStockData() async {
    final response = await http.get(Uri.parse('$baseUrl/stock'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}

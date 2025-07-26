import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'presentation/screens/supplier_list_screen.dart';
import 'presentation/screens/customer_list_screen.dart';
import 'presentation/screens/purchase_screen.dart';
import 'presentation/screens/stock_list_screen.dart';

// State Providers
import 'presentation/state/supplier_provider.dart';
import 'presentation/state/customer_provider.dart';
import 'presentation/state/purchase_provider.dart';
import 'presentation/state/stock_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SupplierProvider()..fetchSuppliers(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomerProvider()..fetchCustomers(),
        ),
        ChangeNotifierProvider(
          create: (_) => PurchaseProvider()..fetchPurchases(),
        ),
        ChangeNotifierProvider(
          create: (_) => StockProvider()..fetchStockData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A237E)),
        ),
        initialRoute: '/purchase',
        routes: {
          '/purchase': (context) => const PurchaseScreen(),
          '/supplier_list': (context) => const SupplierListScreen(),
          '/customer_list': (context) => const CustomerListScreen(),
          '/stock': (context) => StockListScreen(),
        },
      ),
    );
  }
}

// Temporary StockScreen for navigation (not needed if you use StockListScreen)
class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Page')),
      body: const Center(
        child: Text('Stock page content goes here'),
      ),
    );
  }
}

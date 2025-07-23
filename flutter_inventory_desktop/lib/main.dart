// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/supplier_list_screen.dart';
import 'presentation/screens/customer_list_screen.dart';
import 'presentation/state/supplier_provider.dart';
import 'presentation/state/customer_provider.dart';

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
      ],
      child: MaterialApp(
        title: 'Inventory Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A237E)),
        ),
        initialRoute: '/supplier_list',
        routes: {
          '/supplier_list': (context) => const SupplierListScreen(),
          '/customer_list': (context) => const CustomerListScreen(),
        },
      ),
    );
  }
}

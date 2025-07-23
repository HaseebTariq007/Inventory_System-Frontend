// lib/presentation/widgets/custom_nav_bar.dart
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF55221),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: SafeArea(
        child: Row(
          children: [
            const Text(
              'Logo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 24),
            _buildNavButton(context, 'Dashboard'),
            _buildNavButton(context, 'Supplier List'),
            _buildDropdown('Inventory'),
            _buildNavButton(context, 'Customer List'),
            _buildDropdown('Sale'),
            _buildDropdown('Employee'),
            _buildNavButton(context, 'Daily Expense'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          if (label == 'Supplier List') {
            Navigator.pushReplacementNamed(context, '/supplier_list');
          } else if (label == 'Customer List') {
            Navigator.pushReplacementNamed(context, '/customer_list');
          }
        },
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          hint: Text(label, style: const TextStyle(color: Colors.white)),
          items: const [
            DropdownMenuItem(child: Text('Option 1'), value: '1'),
            DropdownMenuItem(child: Text('Option 2'), value: '2'),
          ],
          onChanged: (value) {},
          iconEnabledColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

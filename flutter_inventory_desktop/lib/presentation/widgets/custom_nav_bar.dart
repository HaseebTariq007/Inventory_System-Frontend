import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF55221),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Row(
              children: [
                _buildNavButton(context, 'Dashboard'),
                const SizedBox(width: 12),
                _buildNavButton(context, 'Supplier List'),
                const SizedBox(width: 12),
                _buildInventoryDropdown(context),
                const SizedBox(width: 12),
                _buildNavButton(context, 'Customer List'),
                const SizedBox(width: 12),
                _buildDropdown(context, 'Sale'),
                const SizedBox(width: 12),
                _buildDropdown(context, 'Employee'),
                const SizedBox(width: 12),
                _buildNavButton(context, 'Daily Expense'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String label) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: () {
          if (label == 'Supplier List') {
            Navigator.pushReplacementNamed(context, '/supplier_list');
          } else if (label == 'Customer List') {
            Navigator.pushReplacementNamed(context, '/customer_list');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label navigation not implemented.')),
            );
          }
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, String label) {
    return SizedBox(
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          hint: Text(label, style: const TextStyle(color: Colors.white)),
          items: const [
            DropdownMenuItem(child: Text('Option 1'), value: '1'),
            DropdownMenuItem(child: Text('Option 2'), value: '2'),
          ],
          onChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label -> Option $value selected')),
            );
          },
          iconEnabledColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInventoryDropdown(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          hint: const Text('Inventory', style: TextStyle(color: Colors.white)),
          iconEnabledColor: Colors.white,
          items: const [
            DropdownMenuItem(
              value: 'purchase',
              child: Text('Purchase Product'),
            ),
            DropdownMenuItem(
              value: 'stock',
              child: Text('Stock Page'),
            ),
          ],
          onChanged: (value) {
            if (value == 'purchase') {
              Navigator.pushReplacementNamed(context, '/purchase');
            } else if (value == 'stock') {
              Navigator.pushReplacementNamed(context, '/stock');
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

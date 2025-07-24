import 'package:flutter/material.dart';

class ItemDropdown extends StatelessWidget {
  final String? selectedItem;
  final List<String> items;
  final void Function(String?) onChanged;

  const ItemDropdown({
    Key? key,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
  labelText: 'Select Item',
  filled: true,
  fillColor: Colors.grey.shade200,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
),
      value: selectedItem,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

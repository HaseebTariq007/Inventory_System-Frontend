import 'package:flutter/material.dart';

class TypeDropdown extends StatelessWidget {
  final String? selectedType;
  final List<String> types;
  final void Function(String?) onChanged;

  const TypeDropdown({
    Key? key,
    required this.selectedType,
    required this.types,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Type',
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      value: selectedType,
      items: types
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

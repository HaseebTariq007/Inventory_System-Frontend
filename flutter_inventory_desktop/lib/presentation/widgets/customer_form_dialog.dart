import 'package:flutter/material.dart';

class CustomerFormDialog extends StatefulWidget {
  final Map<String, dynamic>? customer;
  final Function(String, String, String) onSubmit;

  const CustomerFormDialog({super.key, this.customer, required this.onSubmit});

  @override
  State<CustomerFormDialog> createState() => _CustomerFormDialogState();
}

class _CustomerFormDialogState extends State<CustomerFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  bool get isEditing => widget.customer != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.customer?['name'] ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.customer?['phone'] ?? '',
    );
    _addressController = TextEditingController(
      text: widget.customer?['address'] ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _nameController.text,
        _phoneController.text,
        _addressController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF55221),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  isEditing ? 'UPDATE CUSTOMER' : 'ADD CUSTOMER',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nameController, 'Enter Customer name'),
                    const SizedBox(height: 16),
                    _buildTextField(_phoneController, 'Enter Phone number'),
                    const SizedBox(height: 16),
                    _buildTextField(_addressController, 'Enter Address'),
                    const SizedBox(height: 24),

                    // Submit Button (Add or Update)
                    ElevatedButton.icon(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF55221),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(
                        isEditing ? Icons.update : Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        isEditing ? 'Update Customer' : 'Add Customer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Required' : null,
    );
  }
}

// // Navbar shifted to right

// import 'package:flutter/material.dart';

// class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   const CustomNavBar({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: const Color(0xFFF55221),
//       automaticallyImplyLeading: false,
//       title: Row(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Spacer(), // Pushes navigation items to the right
//           Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceEvenly, // Equal spacing between items
//             children: [
//               _buildNavButton(context, 'Dashboard'),
//               const SizedBox(width: 12),
//               _buildNavButton(context, 'Supplier List'),
//               const SizedBox(width: 12),
//               _buildInventoryDropdown(context),
//               const SizedBox(width: 12),
//               _buildNavButton(context, 'Customer List'),
//               const SizedBox(width: 12),
//               _buildSaleDropdown(context),
//               const SizedBox(width: 12),
//               _buildDropdown(context, 'Employee'),
//               const SizedBox(width: 12),
//               _buildNavButton(context, 'Daily Expense'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavButton(BuildContext context, String label) {
//     return SizedBox(
//       height: 40,
//       child: TextButton(
//         onPressed: () {
//           if (label == 'Supplier List') {
//             Navigator.pushReplacementNamed(context, '/supplier_list');
//           } else if (label == 'Customer List') {
//             Navigator.pushReplacementNamed(context, '/customer_list');
//           } else if (label == 'Dashboard') {
//             Navigator.pushReplacementNamed(context, '/dashboard');
//           } else if (label == 'Daily Expense') {
//             Navigator.pushReplacementNamed(context, '/expense');
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('$label navigation not implemented.')),
//             );
//           }
//         },
//         style: TextButton.styleFrom(
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//         ),
//         child: Text(label),
//       ),
//     );
//   }

//   Widget _buildInventoryDropdown(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: PopupMenuButton<String>(
//         color: Colors.white,
//         icon: const Row(
//           children: [
//             Text('Inventory', style: TextStyle(color: Colors.white)),
//             Icon(Icons.arrow_drop_down, color: Colors.white),
//           ],
//         ),
//         onSelected: (value) {
//           if (value == 'purchase') {
//             Navigator.pushReplacementNamed(context, '/purchase');
//           } else if (value == 'stock') {
//             Navigator.pushReplacementNamed(context, '/stock');
//           }
//         },
//         itemBuilder:
//             (BuildContext context) => [
//               const PopupMenuItem<String>(
//                 value: 'purchase',
//                 child: Text('Purchase Product'),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'stock',
//                 child: Text('Stock Page'),
//               ),
//             ],
//         offset: const Offset(0, 40),
//       ),
//     );
//   }

//   // ✅ NEW: Sale dropdown with routes
//   Widget _buildSaleDropdown(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: PopupMenuButton<String>(
//         color: Colors.white,
//         icon: const Row(
//           children: [
//             Text('Sale', style: TextStyle(color: Colors.white)),
//             Icon(Icons.arrow_drop_down, color: Colors.white),
//           ],
//         ),
//         onSelected: (value) {
//           if (value == 'component_sale') {
//             Navigator.pushReplacementNamed(context, '/component_sale');
//           } else if (value == 'sale_report') {
//             Navigator.pushReplacementNamed(context, '/sale_report');
//           }
//         },
//         itemBuilder:
//             (BuildContext context) => [
//               const PopupMenuItem<String>(
//                 value: 'component_sale',
//                 child: Text('Component Sale'),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'sale_report',
//                 child: Text('Sales Report'),
//               ),
//             ],
//         offset: const Offset(0, 40),
//       ),
//     );
//   }

//   // Placeholder for Employee or other dropdowns
//   Widget _buildDropdown(BuildContext context, String label) {
//     return SizedBox(
//       height: 40,
//       child: PopupMenuButton<String>(
//         color: Colors.white,
//         icon: const Row(
//           children: [
//             Text('Employee', style: TextStyle(color: Colors.white)),
//             Icon(Icons.arrow_drop_down, color: Colors.white),
//           ],
//         ),
//         onSelected: (value) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('$label -> Option $value selected')),
//           );
//         },
//         itemBuilder:
//             (BuildContext context) => const [
//               PopupMenuItem<String>(value: '1', child: Text('Option 1')),
//               PopupMenuItem<String>(value: '2', child: Text('Option 2')),
//             ],
//         offset: const Offset(0, 40),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(60);
// }

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
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavButton(context, 'Dashboard'),
              const SizedBox(width: 12),
              _buildNavButton(context, 'Supplier List'),
              const SizedBox(width: 12),
              _buildInventoryDropdown(context),
              const SizedBox(width: 12),
              _buildNavButton(context, 'Customer List'),
              const SizedBox(width: 12),
              _buildSaleDropdown(context),
              const SizedBox(width: 12),
              _buildDropdown(context, 'Employee'),
              const SizedBox(width: 12),
              _buildNavButton(context, 'Daily Expense'),
            ],
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
          } else if (label == 'Dashboard') {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (label == 'Daily Expense') {
            Navigator.pushReplacementNamed(context, '/expense');
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
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Slightly bold
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryDropdown(BuildContext context) {
    return SizedBox(
      height: 40,
      child: PopupMenuButton<String>(
        color: Colors.white,
        icon: const Row(
          children: [
            Text(
              'Inventory',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600, // Slightly bold
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        onSelected: (value) {
          if (value == 'purchase') {
            Navigator.pushReplacementNamed(context, '/purchase');
          } else if (value == 'stock') {
            Navigator.pushReplacementNamed(context, '/stock');
          }
        },
        itemBuilder:
            (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'purchase',
                child: Text('Purchase Product'),
              ),
              const PopupMenuItem<String>(
                value: 'stock',
                child: Text('Stock Page'),
              ),
            ],
        offset: const Offset(0, 40),
      ),
    );
  }

  // ✅ NEW: Sale dropdown with routes
  Widget _buildSaleDropdown(BuildContext context) {
    return SizedBox(
      height: 40,
      child: PopupMenuButton<String>(
        color: Colors.white,
        icon: const Row(
          children: [
            Text(
              'Sale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600, // Slightly bold
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        onSelected: (value) {
          if (value == 'component_sale') {
            Navigator.pushReplacementNamed(context, '/component_sale');
          } else if (value == 'sale_report') {
            Navigator.pushReplacementNamed(context, '/sale_report');
          }
        },
        itemBuilder:
            (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'component_sale',
                child: Text('Component Sale'),
              ),
              const PopupMenuItem<String>(
                value: 'sale_report',
                child: Text('Sales Report'),
              ),
            ],
        offset: const Offset(0, 40),
      ),
    );
  }

  // Placeholder for Employee or other dropdowns
  Widget _buildDropdown(BuildContext context, String label) {
    return SizedBox(
      height: 40,
      child: PopupMenuButton<String>(
        color: Colors.white,
        icon: const Row(
          children: [
            Text(
              'Employee',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600, // Slightly bold
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        onSelected: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label -> Option $value selected')),
          );
        },
        itemBuilder:
            (BuildContext context) => const [
              PopupMenuItem<String>(value: '1', child: Text('Option 1')),
              PopupMenuItem<String>(value: '2', child: Text('Option 2')),
            ],
        offset: const Offset(0, 40),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

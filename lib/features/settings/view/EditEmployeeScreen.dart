import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/settings/view/AddEmployeeScreen.dart';

class EditEmployeeScreen extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EditEmployeeScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return AddEmployeeScreen(employee: employee);
  }
}

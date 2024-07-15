import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/settings/view/pdf_util.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${employee['firstName'] ?? 'N/A'} ${employee['lastName'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text(
                  'Position: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(employee['position'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Text(
                  'Department: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(employee['department'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Text(
                  'Qualifications: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(employee['qualifications'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Text(
                  'City: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(employee['city'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Text(
                  'Experience: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(employee['experienceInPosition'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const Text(
                  'Salary: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(employee['salary']?.toString() ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 8.0),
            IconButton(
              onPressed: () => PDFUtil.generateEmployeePdf(employee),
              icon: const Icon(Icons.print),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'AddEmployeeScreen.dart';
import 'EmployeeListScreen.dart'; // Import the new screen

// ignore: camel_case_types
class staffOverview extends StatefulWidget {
  const staffOverview({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _staffOverviewState createState() => _staffOverviewState();
}

// ignore: camel_case_types
class _staffOverviewState extends State<staffOverview> {
  final staff_database_helper dbHelper = staff_database_helper();

  void removeEmployee() async {
    // Assuming you have the employee ID to delete
    int employeeId = 1;
    await dbHelper.deleteStaff(employeeId);
  }

  Future<void> fetchEmployees() async {
    // ignore: unused_local_variable
    List<Map<String, dynamic>> employees = await dbHelper.getStaff();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmployeeListScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEmployeeScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Add Employye',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  fetchEmployees();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'See All Avilalabel Employye',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

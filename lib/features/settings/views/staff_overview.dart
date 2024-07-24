import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'add_employee_view.dart';
import 'employee_list_view.dart'; // Import the new screen

// ignore: camel_case_types
class staffOverview extends StatefulWidget {
  const staffOverview({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _staffOverviewState createState() => _staffOverviewState();
}

// ignore: camel_case_types
class _staffOverviewState extends State<staffOverview> {
  final StaffDatabaseHelper staffDbHelper = StaffDatabaseHelper();

  void removeEmployee() async {
    // Assuming you have the employee ID to delete
    int employeeId = 1;
    await staffDbHelper.deleteStaff(employeeId);
  }

  Future<void> fetchEmployees() async {
    // ignore: unused_local_variable
    List<Map<String, dynamic>> employees = await staffDbHelper.getStaff();
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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
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
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Add Employye',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  fetchEmployees();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'See All Avilalabel Employye',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  fetchEmployees();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'salaries of employees this month',
                      textAlign: TextAlign.center,
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

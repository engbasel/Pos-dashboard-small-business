import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'AddEmployeeScreen.dart';
import 'EmployeeListScreen.dart'; // Import the new screen

class staffOverview extends StatefulWidget {
  const staffOverview({super.key});

  @override
  _staffOverviewState createState() => _staffOverviewState();
}

class _staffOverviewState extends State<staffOverview> {
  final staff_database_helper dbHelper = staff_database_helper();

  void removeEmployee() async {
    // Assuming you have the employee ID to delete
    int employeeId = 1;
    await dbHelper.deleteStaff(employeeId);
    fetchEmployees();
  }

  void updateEmployee() async {
    Map<String, dynamic> updatedEmployee = {
      'id': 1,
      'firstName': 'Jane',
      'midName': 'Doe',
      'lastName': 'Doe',
      'position': 'Manager',
      'qualifications': 'Master\'s Degree',
      'department': 'Sales',
      'city': 'New York',
      'experienceInPosition': '5 years',
      'salary': 80000.0,
    };
    await dbHelper.updateStaff(updatedEmployee);
    fetchEmployees();
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
    fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                textColor: Colors.black,
                bgColor: Colors.lightGreen,
                text: 'Add Employee',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEmployeeScreen(),
                    ),
                  ).then((_) => fetchEmployees());
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                textColor: Colors.black,
                bgColor: Colors.grey,
                text: 'Employee List',
                onTap: fetchEmployees,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

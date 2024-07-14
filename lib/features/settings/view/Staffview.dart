import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'add_employee_screen.dart';
import 'employee_list_screen.dart'; // Import the new screen

class Staffview extends StatefulWidget {
  const Staffview({super.key});

  @override
  _StaffviewState createState() => _StaffviewState();
}

class _StaffviewState extends State<Staffview> {
  final staff_database_helper _dbHelper = staff_database_helper();

  void _removeEmployee() async {
    // Assuming you have the employee ID to delete
    int employeeId = 1;
    await _dbHelper.deleteStaff(employeeId);
    _fetchEmployees();
  }

  void _updateEmployee() async {
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
    await _dbHelper.updateStaff(updatedEmployee);
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    List<Map<String, dynamic>> employees = await _dbHelper.getStaff();
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
    _fetchEmployees();
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
                  ).then((_) => _fetchEmployees());
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
                onTap: _fetchEmployees,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

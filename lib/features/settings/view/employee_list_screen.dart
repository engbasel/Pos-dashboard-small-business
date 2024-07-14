// // import 'package:flutter/material.dart';

// // class EmployeeListScreen extends StatelessWidget {
// //   final List<Map<String, dynamic>> employees;

// //   const EmployeeListScreen({super.key, required this.employees});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Employee List'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: employees.length,
// //         itemBuilder: (context, index) {
// //           final employee = employees[index];
// //           return Card(
// //             margin: const EdgeInsets.all(8.0),
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     '${employee['firstName'] ?? 'N/A'} ${employee['lastName'] ?? 'N/A'}',
// //                     style: const TextStyle(
// //                       fontSize: 18.0,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8.0),
// //                   Row(
// //                     children: [
// //                       const Text(
// //                         'Position: ',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Text(employee['position'] ?? 'N/A'),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4.0),
// //                   Row(
// //                     children: [
// //                       const Text(
// //                         'Department: ',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Text(employee['department'] ?? 'N/A'),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4.0),
// //                   Row(
// //                     children: [
// //                       const Text(
// //                         'Qualifications: ',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Text(employee['qualifications'] ?? 'N/A'),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4.0),
// //                   Row(
// //                     children: [
// //                       const Text(
// //                         'City: ',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Text(employee['city'] ?? 'N/A'),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4.0),
// //                   Row(
// //                     children: [
// //                       const Text(
// //                         'Experience: ',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Text(employee['experienceInPosition'] ?? 'N/A'),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4.0),
// //                   Row(
// //                     children: [
// //                       const Text(
// //                         'Salary: ',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       Text(employee['salary']?.toString() ?? 'N/A'),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
// import 'add_employee_screen.dart';

// class EmployeeListScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> employees;
//   final staff_database_helper _dbHelper = staff_database_helper();

//   EmployeeListScreen({super.key, required this.employees});

//   void _editEmployee(BuildContext context, Map<String, dynamic> employee) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddEmployeeScreen(employee: employee),
//       ),
//     ).then((_) {
//       // Refresh the employee list after editing
//       Navigator.pop(context);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => EmployeeListScreen(employees: employees),
//         ),
//       );
//     });
//   }

//   void _deleteEmployee(BuildContext context, int id) async {
//     await _dbHelper.deleteStaff(id);
//     Navigator.pop(context);
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EmployeeListScreen(employees: employees),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee List'),
//       ),
//       body: ListView.builder(
//         itemCount: employees.length,
//         itemBuilder: (context, index) {
//           final employee = employees[index];
//           return Card(
//             margin: const EdgeInsets.all(8.0),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${employee['firstName'] ?? 'N/A'} ${employee['lastName'] ?? 'N/A'}',
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Row(
//                     children: [
//                       const Text(
//                         'Position: ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(employee['position'] ?? 'N/A'),
//                     ],
//                   ),
//                   const SizedBox(height: 4.0),
//                   Row(
//                     children: [
//                       const Text(
//                         'Department: ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(employee['department'] ?? 'N/A'),
//                     ],
//                   ),
//                   const SizedBox(height: 4.0),
//                   Row(
//                     children: [
//                       const Text(
//                         'Qualifications: ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(employee['qualifications'] ?? 'N/A'),
//                     ],
//                   ),
//                   const SizedBox(height: 4.0),
//                   Row(
//                     children: [
//                       const Text(
//                         'City: ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(employee['city'] ?? 'N/A'),
//                     ],
//                   ),
//                   const SizedBox(height: 4.0),
//                   Row(
//                     children: [
//                       const Text(
//                         'Experience: ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(employee['experienceInPosition'] ?? 'N/A'),
//                     ],
//                   ),
//                   const SizedBox(height: 4.0),
//                   Row(
//                     children: [
//                       const Text(
//                         'Salary: ',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(employee['salary']?.toString() ?? 'N/A'),
//                     ],
//                   ),
//                   const SizedBox(height: 8.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () => _editEmployee(context, employee),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () =>
//                             _deleteEmployee(context, employee['id']),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'add_employee_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final staff_database_helper _dbHelper = staff_database_helper();
  List<Map<String, dynamic>> _employees = [];

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    final employees = await _dbHelper.getStaff();
    setState(() {
      _employees = employees;
    });
  }

  void _editEmployee(Map<String, dynamic> employee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEmployeeScreen(employee: employee),
      ),
    ).then((_) => _fetchEmployees());
  }

  void _deleteEmployee(int id) async {
    await _dbHelper.deleteStaff(id);
    _fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          final employee = _employees[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${employee['firstName'] ?? 'N/A'} ${employee['lastName'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 18.0,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editEmployee(employee),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteEmployee(employee['id']),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

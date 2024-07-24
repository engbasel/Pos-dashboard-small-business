import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'package:pos_dashboard_v1/features/settings/views/edit_employee_view.dart';
import 'package:pos_dashboard_v1/features/settings/views/employee_detail_view.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final StaffDatabaseHelper dbHelper = StaffDatabaseHelper();
  List<Map<String, dynamic>> _employees = [];
  List<Map<String, dynamic>> _filteredEmployees = [];
  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchEmployees();
    searchController.addListener(updateSearchQuery);
  }

  @override
  void dispose() {
    searchController.removeListener(updateSearchQuery);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchEmployees() async {
    final employees = await dbHelper.getStaff();
    setState(() {
      _employees = employees;
      _filteredEmployees = employees;
    });
  }

  void updateSearchQuery() {
    setState(() {
      _searchQuery = searchController.text;
      filterEmployees();
    });
  }

  void filterEmployees() {
    final query = _searchQuery.toLowerCase();
    setState(() {
      _filteredEmployees = _employees.where((employee) {
        final firstName = employee['firstName']?.toLowerCase() ?? '';
        final lastName = employee['lastName']?.toLowerCase() ?? '';
        final position = employee['position']?.toLowerCase() ?? '';
        final city = employee['city']?.toLowerCase() ?? '';
        final experience =
            employee['experienceInPosition']?.toLowerCase() ?? '';
        final department = employee['department']?.toLowerCase() ?? '';
        final qualifications = employee['qualifications']?.toLowerCase() ?? '';
        final salary = employee['salary']?.toString() ?? '';

        return firstName.contains(query) ||
            lastName.contains(query) ||
            position.contains(query) ||
            city.contains(query) ||
            experience.contains(query) ||
            department.contains(query) ||
            qualifications.contains(query) ||
            salary.contains(query);
      }).toList();
    });
  }

  void editEmployee(Map<String, dynamic> employee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEmployeeScreen(employee: employee),
      ),
    ).then((_) => fetchEmployees());
  }

  void deleteEmployee(int id) async {
    await dbHelper.deleteStaff(id);
    fetchEmployees();
  }

  void viewEmployeeDetails(Map<String, dynamic> employee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailScreen(employee: employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, position, city, etc.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _filteredEmployees.length,
        itemBuilder: (context, index) {
          final employee = _filteredEmployees[index];
          return GestureDetector(
            onTap: () => viewEmployeeDetails(employee),
            child: Card(
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
                          'Fixed Salary: ',
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
                          onPressed: () => editEmployee(employee),

                          // onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteEmployee(employee['id']),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// add print to all employyes in system
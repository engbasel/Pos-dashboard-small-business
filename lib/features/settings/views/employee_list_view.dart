import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'package:pos_dashboard_v1/core/utils/Manager/manager.dart';
import 'package:pos_dashboard_v1/features/settings/views/edit_employee_view.dart';
import 'package:pos_dashboard_v1/features/settings/views/employee_detail_view.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmployeeDetailDialog(employee: employee);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('Employee List')),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Material(
              color: Colors.white,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)
                      .translate('search for an employee'),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.kPrimaryColor,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.kPrimaryColor,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredEmployees.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final employee = _filteredEmployees[index];
                return GestureDetector(
                  onTap: () => viewEmployeeDetails(employee),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: ColorsManager.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${employee['firstName'] ?? 'N/A'} ${employee['lastName'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).translate('Position')} : ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(employee['position'] ?? ''),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).translate('Department')} : ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(employee['department'] ?? ''),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: ColorsManager.kPrimaryColor,
                                ),
                                onPressed: () => editEmployee(employee),

                                // onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
          ),
        ],
      ),
    );
  }
}
// add print to all employyes in system
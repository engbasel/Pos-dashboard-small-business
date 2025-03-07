import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/staff_database_helper.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import '../../../core/utils/models/add_employ_model.dart';
import '../widgets/custom_text_form_field.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Map<String, dynamic>? employee;

  const AddEmployeeScreen({super.key, this.employee});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final formKey = GlobalKey<FormState>();
  final _dbHelper = StaffDatabaseHelper();

  final _firstNameController = TextEditingController();
  final _midNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _qualificationsController = TextEditingController();
  final _departmentController = TextEditingController();
  final _cityController = TextEditingController();
  final _experienceInPositionController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _firstNameController.text = widget.employee!['firstName'] ?? '';
      _midNameController.text = widget.employee!['midName'] ?? '';
      _lastNameController.text = widget.employee!['lastName'] ?? '';
      _positionController.text = widget.employee!['position'] ?? '';
      _qualificationsController.text = widget.employee!['qualifications'] ?? '';
      _departmentController.text = widget.employee!['department'] ?? '';
      _cityController.text = widget.employee!['city'] ?? '';
      _experienceInPositionController.text =
          widget.employee!['experienceInPosition'] ?? '';
      _salaryController.text = widget.employee!['salary']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _midNameController.dispose();
    _lastNameController.dispose();
    _positionController.dispose();
    _qualificationsController.dispose();
    _departmentController.dispose();
    _cityController.dispose();
    _experienceInPositionController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void saveEmployee() async {
    if (formKey.currentState!.validate()) {
      final newEmployee = AddEmployeeModel(
        firstName: _firstNameController.text,
        midName: _midNameController.text,
        lastName: _lastNameController.text,
        position: _positionController.text,
        qualifications: _qualificationsController.text,
        department: _departmentController.text,
        city: _cityController.text,
        experienceInPosition: _experienceInPositionController.text,
        salary: double.parse(_salaryController.text),
      );
      if (widget.employee == null) {
        // Adding a new employee
        await _dbHelper.saveStaff(newEmployee.toMap());
      } else {
        // Editing an existing employee
        newEmployee.id = widget.employee!['id'];
        await _dbHelper.updateStaff(newEmployee.toMap());
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.employee == null
              ? AppLocalizations.of(context).translate('Add Employee')
              : AppLocalizations.of(context).translate('Edit Employee'),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _firstNameController,
                  labelText:
                      AppLocalizations.of(context).translate('First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _midNameController,
                  labelText:
                      AppLocalizations.of(context).translate('Middle Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter middle name';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _lastNameController,
                  labelText:
                      AppLocalizations.of(context).translate('Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _positionController,
                  labelText: AppLocalizations.of(context).translate('Position'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter position';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _qualificationsController,
                  labelText:
                      AppLocalizations.of(context).translate('Qualifications'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter qualifications';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _departmentController,
                  labelText:
                      AppLocalizations.of(context).translate('Department'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter department';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _cityController,
                  labelText: AppLocalizations.of(context).translate('City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _experienceInPositionController,
                  labelText:
                      AppLocalizations.of(context).translate('Experience'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter experience in position';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: _salaryController,
                  labelText: AppLocalizations.of(context).translate('Salary'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter salary';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                CustomButton(
                  text: widget.employee == null
                      ? AppLocalizations.of(context).translate('Add Employee')
                      : AppLocalizations.of(context).translate('Save Changes'),
                  onTap: saveEmployee,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

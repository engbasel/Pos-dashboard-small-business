import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/settings/views/extraditeals_view.dart';
import 'package:pos_dashboard_v1/features/settings/views/pdf_util.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class EmployeeDetailDialog extends StatelessWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetailDialog({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('Employee Details')),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${employee['firstName'] ?? ''} ${employee['lastName'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).translate('Qualifications')} : ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(employee['qualifications'] ?? ''),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).translate('City')} : ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(employee['city'] ?? ''),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).translate('Experience')} : ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(employee['experienceInPosition'] ?? ''),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).translate('Salary')} : ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(employee['salary']?.toString() ?? ''),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomSmallButton(
                      icon: Icons.info_outline_rounded,
                      text: AppLocalizations.of(context)
                          .translate('Extra details'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ExtraditealsScreen(
                            employee: employee,
                          );
                        }));
                      },
                    ),
                    const SizedBox(width: 16),
                    CustomSmallButton(
                      icon: Icons.print,
                      text:
                          AppLocalizations.of(context).translate('printOrder'),
                      onTap: () => PDFUtil.generateEmployeePdf(employee),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

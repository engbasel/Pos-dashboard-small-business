import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/Manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/client/views/CustomerDetailView.dart';
import 'package:pos_dashboard_v1/features/client/widgets/edit_customer_dialog.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class CustomDetailsCard extends StatelessWidget {
  final Map<String, dynamic> customer;
  final Function(Map<String, String>) onEdit;
  final Function(int) onDelete;
  final VoidCallback onTap;

  const CustomDetailsCard({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CustomerDetailPage(customerId: customer['id']),
          ),
        );
      },
      child: Card(
        color: ColorsManager.backgroundColor,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${customer['fullName']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final updatedCustomer =
                          await showDialog<Map<String, String>>(
                        context: context,
                        builder: (context) =>
                            EditCustomerDialog(customer: customer),
                      );
                      if (updatedCustomer != null) {
                        onEdit(updatedCustomer);
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: ColorsManager.kPrimaryColor,
                    ),
                    tooltip: AppLocalizations.of(context).translate('edit'),
                  ),
                  IconButton(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return const DeleteConformationDialog();
                        },
                      );

                      if (confirmed == true) {
                        onDelete(customer['id']);
                        Navigator.of(context).pop(true);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    tooltip: AppLocalizations.of(context).translate('delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

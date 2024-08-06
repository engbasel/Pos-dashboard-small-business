import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import 'package:pos_dashboard_v1/features/orders/widgets/order_details.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;
  final Function(int) onDelete;

  const OrdersList({
    super.key,
    required this.orders,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final invoice = orders[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return OrderDetails(invoice: invoice);
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorsManager.backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  ${AppLocalizations.of(context).translate('Invoice')} #${invoice.invoiceNumber}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '  ${AppLocalizations.of(context).translate('Customer')}: ${invoice.customerName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final bool? confirmed = await showDialog(
                        context: context,
                        builder: (context) => const DeleteConformationDialog(),
                      );
                      if (confirmed == true) {
                        onDelete(index);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

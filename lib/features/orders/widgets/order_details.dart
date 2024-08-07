import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import '../../../l10n/app_localizations.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.invoice});

  final Order invoice;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Text(
              '${AppLocalizations.of(context).translate('Invoice')}  #${invoice.invoiceNumber}'),
          const Spacer(),
          CustomSmallButton(
            onTap: () {},
            icon: Icons.print,
            text: 'print',
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${AppLocalizations.of(context).translate('CustomerName')}: ${invoice.customerName}'),
              Text(
                  '${AppLocalizations.of(context).translate('date')}: ${invoice.invoiceDate}'),
              Text(
                  '${AppLocalizations.of(context).translate('InvoiceNumber')}: ${invoice.invoiceNumber}'),
              const SizedBox(height: 12),
              Text('${AppLocalizations.of(context).translate('Items')}:'),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                      AppLocalizations.of(context).translate('No.'),
                    )),
                    DataColumn(
                      label: Text(
                        AppLocalizations.of(context).translate('Product'),
                      ),
                    ),
                    DataColumn(
                        label: Text(AppLocalizations.of(context)
                            .translate('Quantity'))),
                    DataColumn(
                        label: Text(AppLocalizations.of(context)
                            .translate('UnitPrice'))),
                    DataColumn(
                        label: Text(
                            AppLocalizations.of(context).translate('Total'))),
                    DataColumn(
                        label: Text(AppLocalizations.of(context)
                            .translate('Discount'))),
                  ],
                  rows: invoice.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return DataRow(
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(item.name)),
                        DataCell(Text('${item.quantity}')),
                        DataCell(Text('\$${item.unitPrice}')),
                        DataCell(Text('\$${item.total}')),
                        DataCell(Text('\$${item.discount}')),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${AppLocalizations.of(context).translate('Tax')} \$20',
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomSmallButton(
                    icon: Icons.close,
                    onTap: () => Navigator.of(context).pop(),
                    text: AppLocalizations.of(context).translate('Close'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

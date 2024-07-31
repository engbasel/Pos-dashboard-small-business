import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class NeededProductsDetails extends StatelessWidget {
  final IncomingOrderModel product;

  const NeededProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('orderDetails'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                title: Text(AppLocalizations.of(context).translate('orderId')),
                subtitle: Text(product.orderId),
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate('supplierName')),
                subtitle: Text(product.supplierName),
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context).translate('orderDate')),
                subtitle: Text(product.orderDate),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)
                    .translate('expectedDeliveryDate')),
                subtitle: Text(product.expectedDeliveryDate),
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context).translate('orderStatus')),
                subtitle: Text(product.orderStatus),
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context).translate('totalAmount')),
                subtitle: Text(product.totalAmount.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

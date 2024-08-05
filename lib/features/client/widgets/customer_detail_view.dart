import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class CustomerDetailView extends StatelessWidget {
  final Map<String, dynamic> customer;

  const CustomerDetailView({
    required this.customer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).translate('customerDetails'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('fullName'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(customer['fullName']),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('indebtedness'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(customer['indebtedness']),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('currentAccount'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(customer['currentAccount']),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('notes'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(customer['notes']),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

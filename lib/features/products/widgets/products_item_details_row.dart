import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class ProductsItemDetailsRow extends StatelessWidget {
  const ProductsItemDetailsRow({
    super.key,
    required this.labelKey,
    this.value,
  });
  final String labelKey;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).translate(labelKey),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

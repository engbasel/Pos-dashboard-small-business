import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class ProdactsReportsDietalis extends StatelessWidget {
  const ProdactsReportsDietalis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).translate('clientsReports'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSmallButton(
                  icon: Icons.print,
                  text: AppLocalizations.of(context).translate('printReport'),
                  // onTap: printPDF,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSmallButton(
                  icon: Icons.picture_as_pdf,
                  text: AppLocalizations.of(context).translate('ExportasPDF'),
                  // onTap: exportPDF,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

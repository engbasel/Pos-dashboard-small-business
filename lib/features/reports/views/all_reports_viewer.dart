import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/features/reports/views/ClientsReportsDietalis.dart';
import 'package:pos_dashboard_v1/features/reports/views/ProdactsReportsDietalis.dart';
import 'package:pos_dashboard_v1/features/reports/views/retern_invoices_manager.dart';
import 'package:pos_dashboard_v1/features/reports/views/sales_invoices_report_view.dart';
import 'package:pos_dashboard_v1/features/reports/widgets/custom_genral_report_item.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class AllReportesViwer extends StatelessWidget {
  const AllReportesViwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: AppLocalizations.of(context).translate('reports')),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                CoustomGenralReportItem(
                  title: 'تقارير المبيعات',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SalesInvoicesReportScreen(),
                      ),
                    );
                  },
                ),
                CoustomGenralReportItem(
                  title: 'تقارير المسترجعات',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ReternInvocMentMangaer(),
                      ),
                    );
                  },
                ),
                CoustomGenralReportItem(
                  title: 'تقارير العملاء',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ClientsReportsDietalis();
                        },
                      ),
                    );
                  },
                ),
                CoustomGenralReportItem(
                  title: 'اتقارير لبضاعة بالمخزن',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ProdactsReportsDietalis();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../l10n/app_localizations.dart';

class ReturnInvoiceDetailScreen extends StatefulWidget {
  final ReturnInvoiceModel returnInvoice;

  const ReturnInvoiceDetailScreen({
    super.key,
    required this.returnInvoice,
  });

  @override
  State<ReturnInvoiceDetailScreen> createState() =>
      _ReturnInvoiceDetailScreenState();
}

class _ReturnInvoiceDetailScreenState extends State<ReturnInvoiceDetailScreen> {
  late ReturnInvoiceModel returnInvoice;

  @override
  void initState() {
    super.initState();
    returnInvoice = widget.returnInvoice;
  }

  void updateReturnInvoice(ReturnInvoiceModel updatedInvoice) {
    setState(() {
      returnInvoice = updatedInvoice;
    });
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context pwContext) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                  '${AppLocalizations.of(context).translate('invoiceId')}: ${returnInvoice.id}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  '${AppLocalizations.of(context).translate('orderId')}: ${returnInvoice.orderId}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  '${AppLocalizations.of(context).translate('totalBackMoney')}: \$${returnInvoice.totalbackmony.toStringAsFixed(2)}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  '${AppLocalizations.of(context).translate('returnDate')}: ${returnInvoice.returnDate}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  '${AppLocalizations.of(context).translate('employee')}: ${returnInvoice.employee}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  '${AppLocalizations.of(context).translate('reason')}: ${returnInvoice.reason}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  '${AppLocalizations.of(context).translate('amount')}: \$${returnInvoice.amount.toStringAsFixed(2)}'),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "ReturnInvoice_${returnInvoice.id}.pdf",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate('returnInvoiceDetails'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // CustomSmallButton(
                  //   icon: Icons.edit,
                  //   text: AppLocalizations.of(context).translate('edit'),
                  //   onTap: () async {
                  //     final updatedInvoice = await Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => EditReturnInvoiceItemScreen(
                  //           returnInvoice: returnInvoice,
                  //           onUpdate: updateReturnInvoice,
                  //         ),
                  //       ),
                  //     );
                  //     if (updatedInvoice != null) {
                  //       updateReturnInvoice(
                  //           updatedInvoice); // Update the UI with the new data
                  //     }
                  //   },
                  // ),
                  const SizedBox(width: 8),
                  CustomSmallButton(
                    icon: Icons.print,
                    text: AppLocalizations.of(context).translate('printOrder'),
                    onTap: () => generatePdf(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildDetailRow(
                  AppLocalizations.of(context).translate('invoiceId'),
                  returnInvoice.id.toString()),
              buildDetailRow(AppLocalizations.of(context).translate('orderId'),
                  returnInvoice.orderId.toString()),
              buildDetailRow(
                  AppLocalizations.of(context).translate('totalBackMoney'),
                  '\$${returnInvoice.totalbackmony.toStringAsFixed(2)}'),
              buildDetailRow(
                  AppLocalizations.of(context).translate('returnDate'),
                  returnInvoice.returnDate),
              buildDetailRow(AppLocalizations.of(context).translate('employee'),
                  returnInvoice.employee),
              buildDetailRow(AppLocalizations.of(context).translate('reason'),
                  returnInvoice.reason),
              buildDetailRow(AppLocalizations.of(context).translate('amount'),
                  '\$${returnInvoice.amount.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

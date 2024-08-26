import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    // Load a font that supports Arabic or other RTL languages
    final arabicFontData =
        await rootBundle.load('assets/fonts/Traditional-Arabic.ttf');
    final arabicFont = pw.Font.ttf(arabicFontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context pwContext) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${AppLocalizations.of(context).translate('invoiceId')}: ${returnInvoice.id}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${AppLocalizations.of(context).translate('orderId')}: ${returnInvoice.orderId}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${AppLocalizations.of(context).translate('totalBackMoney')}: \$${returnInvoice.totalbackmony.toStringAsFixed(2)}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${AppLocalizations.of(context).translate('returnDate')}: ${returnInvoice.returnDate}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${AppLocalizations.of(context).translate('employee')}: ${returnInvoice.employee}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${AppLocalizations.of(context).translate('reason')}: ${returnInvoice.reason}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  '${AppLocalizations.of(context).translate('amount')}: \$${returnInvoice.amount.toStringAsFixed(2)}',
                  style: pw.TextStyle(font: arabicFont),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.right,
                ),
              ],
            ),
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

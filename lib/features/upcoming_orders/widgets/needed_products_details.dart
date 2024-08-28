import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'dart:io';
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
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('orderDetails'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // IconButton(
                  //   icon: const Icon(Icons.print),
                  //   onPressed: () => exportToPdf(context),
                  // ),

                  CustomSmallButton(
                    icon: Icons.print,
                    onTap: () {
                      exportToPdf(context);
                    },
                    text: AppLocalizations.of(context).translate('printOrder'),
                  )
                ],
              ),
              const SizedBox(height: 24),
              buildDetailRow(
                AppLocalizations.of(context).translate('orderId'),
                product.orderId,
              ),
              buildDetailRow(
                AppLocalizations.of(context).translate('supplierName'),
                product.supplierName,
              ),
              buildDetailRow(
                AppLocalizations.of(context).translate('orderDate'),
                product.orderDate,
              ),
              buildDetailRow(
                AppLocalizations.of(context).translate('expectedDeliveryDate'),
                product.expectedDeliveryDate,
              ),
              buildDetailRow(
                AppLocalizations.of(context).translate('orderStatus'),
                product.orderStatus,
              ),
              buildDetailRow(
                AppLocalizations.of(context).translate('totalAmount'),
                product.totalAmount.toString(),
              ),
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

  pw.Widget buildPdfDetailRow(String label, String value, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
          pw.Text(value, style: pw.TextStyle(font: font)),
        ],
      ),
    );
  }

  Future<void> exportToPdf(BuildContext context) async {
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
                pw.Text('تفاصيل طلب المنتجات',
                    style: pw.TextStyle(font: arabicFont, fontSize: 24)),
                pw.SizedBox(height: 24),
                buildPdfDetailRow(
                  AppLocalizations.of(context).translate('orderId'),
                  product.orderId,
                  arabicFont,
                ),
                buildPdfDetailRow(
                  AppLocalizations.of(context).translate('supplierName'),
                  product.supplierName,
                  arabicFont,
                ),
                buildPdfDetailRow(
                  AppLocalizations.of(context).translate('orderDate'),
                  product.orderDate,
                  arabicFont,
                ),
                buildPdfDetailRow(
                  AppLocalizations.of(context)
                      .translate('expectedDeliveryDate'),
                  product.expectedDeliveryDate,
                  arabicFont,
                ),
                buildPdfDetailRow(
                  AppLocalizations.of(context).translate('orderStatus'),
                  product.orderStatus,
                  arabicFont,
                ),
                buildPdfDetailRow(
                  AppLocalizations.of(context).translate('totalAmount'),
                  product.totalAmount.toString(),
                  arabicFont,
                ),
              ],
            ),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/OrderDetails_${product.orderId}.pdf');

    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تصدير ملف PDF إلى ${file.path}')),
    );
  }
}

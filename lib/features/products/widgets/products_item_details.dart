import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/products/widgets/products_item_details_row.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class ProductItemDetails extends StatelessWidget {
  final ItemModel item;

  const ProductItemDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)
                      .translate('productDetails'), // Localized string
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.print),
                  onPressed: () {
                    exportPDF(context, item: item);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.image != null)
                      Image.file(
                        File(item.image!),
                        width: MediaQuery.of(context).size.width * .8,
                        height: 300,
                      ),
                    const SizedBox(height: 16),
                    buildDetailRows(context, item),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRows(BuildContext context, ItemModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('item_name'), // Localized string
          value: item.name,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('description'), // Localized string
          value: item.description,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey:
              AppLocalizations.of(context).translate('sku'), // Localized string
          value: item.sku,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('barcode'), // Localized string
          value: item.barcode,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('purchasePrice'), // Localized string
          value: item.price?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('salePrice'), // Localized string
          value: item.unitPrice?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('wholesalePrice'), // Localized string
          value: item.wholesalePrice?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('taxRate'), // Localized string
          value: item.taxRate?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('quantity'), // Localized string
          value: item.quantity?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('alertQuantity'), // Localized string
          value: item.alertQuantity?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('image_url'), // Localized string
          value: item.image,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('brand'), // Localized string
          value: item.brand,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('size'), // Localized string
          value: item.size,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('weight'), // Localized string
          value: item.weight?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('color'), // Localized string
          value: item.color,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('material'), // Localized string
          value: item.material,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('warranty'), // Localized string
          value: item.warranty,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('supplier_id'), // Localized string
          value: item.supplierId?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('item_status'), // Localized string
          value: item.itemStatus,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: AppLocalizations.of(context)
              .translate('date_modified'), // Localized string
          value: item.dateModified?.toString(),
        ),
      ],
    );
  }

  pw.Widget buildPdfDetailRow(String key, String? value, pw.Font arabicFont) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Text(
              '$key:',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: arabicFont,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value ?? '',
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: arabicFont),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> exportPDF(BuildContext context,
      {required ItemModel item}) async {
    try {
      final pdf = pw.Document();

      // Load the custom Arabic font
      final arabicFontData =
          await rootBundle.load('assets/fonts/Traditional-Arabic.ttf');
      final arabicFont = pw.Font.ttf(arabicFontData);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.roll80,
          build: (pw.Context pdfContext) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    AppLocalizations.of(context)
                        .translate('productDetails'), // Localized string
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: arabicFont,
                    ),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 16),
                  buildPdfDetailRow(
                    AppLocalizations.of(context)
                        .translate('item_name'), // Localized string
                    item.name,
                    arabicFont,
                  ),
                  buildPdfDetailRow(
                    AppLocalizations.of(context)
                        .translate('description'), // Localized string
                    item.description,
                    arabicFont,
                  ),
                  buildPdfDetailRow(
                    AppLocalizations.of(context)
                        .translate('color'), // Localized string
                    item.color,
                    arabicFont,
                  ),
                  buildPdfDetailRow(
                    AppLocalizations.of(context)
                        .translate('material'), // Localized string
                    item.material,
                    arabicFont,
                  ),
                  buildPdfDetailRow(
                    AppLocalizations.of(context)
                        .translate('size'), // Localized string
                    item.size,
                    arabicFont,
                  ),
                  // pw.Text('تحت اشراف ادارة المحل ')

                  pw.Text(
                    'تحت اشراف ادارة المحل',
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(font: arabicFont),
                  ),
                ],
              ),
            );
          },
        ),
      );

      final result = await FilePicker.platform.saveFile(
        dialogTitle: AppLocalizations.of(context)
            .translate('select_where_to_save_pdf'), // Localized string
        fileName: 'product_details_${item.sku}.pdf',
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsBytes(await pdf.save());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)
                  .translate('pdf_saved_successfully'), // Localized string
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)
                .translate('error_saving_pdf'), // Localized string
          ),
        ),
      );
    }
  }
}

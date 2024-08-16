import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/products/widgets/products_item_details_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

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
                const Text(
                  'Product Details',
                  style: TextStyle(
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
                    buildDetailRows(item),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRows(ItemModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductsItemDetailsRow(
          labelKey: 'item_name',
          value: item.name,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'description',
          value: item.description,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'sku',
          value: item.sku,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'barcode',
          value: item.barcode,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'purchase_price',
          value: item.price?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'sale_price',
          value: item.unitPrice?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'wholesale_price',
          value: item.wholesalePrice?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'tax_rate',
          value: item.taxRate?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'quantity',
          value: item.quantity?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'alert_quantity',
          value: item.alertQuantity?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'image_url',
          value: item.image,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'brand',
          value: item.brand,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'size',
          value: item.size,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'weight',
          value: item.weight?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'color',
          value: item.color,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'material',
          value: item.material,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'warranty',
          value: item.warranty,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'supplier_id',
          value: item.supplierId?.toString(),
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'item_status',
          value: item.itemStatus,
        ),
        const Divider(),
        ProductsItemDetailsRow(
          labelKey: 'date_modified',
          value: item.dateModified?.toString(),
        ),
      ],
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
          build: (context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Product Details',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      font: arabicFont,
                    ),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 16),
                  buildPdfDetailRow('Product Name', item.name, arabicFont),
                  buildPdfDetailRow(
                      'Description', item.description, arabicFont),
                  buildPdfDetailRow('SKU', item.sku, arabicFont),
                  buildPdfDetailRow('Barcode', item.barcode, arabicFont),
                  buildPdfDetailRow(
                      'Purchase Price', item.price?.toString(), arabicFont),
                  buildPdfDetailRow(
                      'Sale Price', item.unitPrice?.toString(), arabicFont),
                  buildPdfDetailRow('Wholesale Price',
                      item.wholesalePrice?.toString(), arabicFont),
                  buildPdfDetailRow(
                      'Tax Rate', item.taxRate?.toString(), arabicFont),
                  buildPdfDetailRow(
                      'Quantity', item.quantity?.toString(), arabicFont),
                  buildPdfDetailRow('Alert Quantity',
                      item.alertQuantity?.toString(), arabicFont),
                  buildPdfDetailRow('Image URL', item.image, arabicFont),
                  buildPdfDetailRow('Brand', item.brand, arabicFont),
                  buildPdfDetailRow('Size', item.size, arabicFont),
                  buildPdfDetailRow(
                      'Weight', item.weight?.toString(), arabicFont),
                  buildPdfDetailRow('Color', item.color, arabicFont),
                  buildPdfDetailRow('Material', item.material, arabicFont),
                  buildPdfDetailRow('Warranty', item.warranty, arabicFont),
                  buildPdfDetailRow(
                      'Supplier ID', item.supplierId?.toString(), arabicFont),
                  buildPdfDetailRow('Item Status', item.itemStatus, arabicFont),
                  buildPdfDetailRow('Date Modified',
                      item.dateModified?.toString(), arabicFont),
                ],
              ),
            );
          },
        ),
      );

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Select where to save PDF',
        fileName: 'product_details_${item.sku}.pdf',
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsBytes(await pdf.save());

        if (await file.exists()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF saved to ${file.path}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save PDF')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF export canceled')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  pw.Widget buildPdfDetailRow(String label, String? value, pw.Font arabicFont) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '$label: ',
            style:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, font: arabicFont),
          ),
          pw.Expanded(
            child: pw.Text(
              value ?? 'N/A',
              style: pw.TextStyle(font: arabicFont),
              textDirection: pw.TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}

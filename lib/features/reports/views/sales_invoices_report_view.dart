import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pos_dashboard_v1/features/orders/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import 'package:pos_dashboard_v1/features/orders/widgets/order_details.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_small_button.dart';
import '../../../l10n/app_localizations.dart';

class SalesInvoicesReportScreen extends StatefulWidget {
  const SalesInvoicesReportScreen({super.key});

  @override
  State<SalesInvoicesReportScreen> createState() =>
      _SalesInvoicesReportScreenState();
}

class _SalesInvoicesReportScreenState extends State<SalesInvoicesReportScreen> {
  List<Order> invoices = [];
  // List<ReturnInvoiceModel> returnInvoices = [];

  @override
  void initState() {
    super.initState();
    _loadInvoices();
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

  Future<void> exportPDF(BuildContext context) async {
    try {
      final pdf = await generatePDF();

      final result = await FilePicker.platform.saveFile(
        dialogTitle:
            AppLocalizations.of(context).translate('select_where_to_save_pdf'),
        fileName: 'sales_invoices_report.pdf',
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsBytes(await pdf.save());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).translate('pdf_saved_successfully'),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).translate('error_saving_pdf'),
          ),
        ),
      );
    }
  }

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();

    // Load the custom Arabic font
    final arabicFontData =
        await rootBundle.load('assets/fonts/Traditional-Arabic.ttf');
    final arabicFont = pw.Font.ttf(arabicFontData);

    final totalItemsReturned = invoices.length;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('تقرير الفواتير المرتجعة',
                    style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        font: arabicFont)),
                pw.SizedBox(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Text('رقم الفاتورة',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                        pw.Text('رقم الطلب',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                        pw.Text('الموظف',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                        pw.Text('السبب',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                        pw.Text('تاريخ الارجاع',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                        pw.Text('المبلغ المسترد',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                      ],
                    ),
                    ...invoices.map((invoice) => pw.TableRow(
                          children: [
                            pw.Text(
                              invoice.invoiceNumber,
                              style: pw.TextStyle(font: arabicFont),
                            ),
                            pw.Text(
                              invoice.invoiceNumber.toString(),
                              style: pw.TextStyle(font: arabicFont),
                            ),
                            pw.Text(
                              invoice.customerName,
                              style: pw.TextStyle(font: arabicFont),
                            ),
                            pw.Text(
                              invoice.invoiceDate,
                              style: pw.TextStyle(font: arabicFont),
                            ),
                            pw.Text(
                              invoice.invoiceNumber,
                              style: pw.TextStyle(font: arabicFont),
                            ),
                            pw.Text(
                              invoice.invoiceNumber.toString(),
                              style: pw.TextStyle(font: arabicFont),
                            ),
                          ],
                        )),
                    pw.TableRow(
                      children: [
                        pw.Text(''),
                        pw.Text(''),
                        pw.Text(''),
                        pw.Text(''),
                        pw.Text(
                          'الاجمالي:',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: arabicFont,
                          ),
                        ),
                        pw.Text(
                          'المبلغ الإجمالي',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: arabicFont,
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text(''),
                        pw.Text(''),
                        pw.Text(''),
                        pw.Text(''),
                        pw.Text(
                          'الاجمالي:',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: arabicFont,
                          ),
                        ),
                        pw.Text(totalItemsReturned.toString(),
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: arabicFont)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  Future<void> printPDF() async {
    final pdf = await generatePDF();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF sent to printer')),
    );
  }

  Future<void> _loadInvoices() async {
    final loadedInvoices =
        await SalesDatabaseHelper.instance.getSalesInvoices();
    setState(() {
      invoices = loadedInvoices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).translate('SalesBill'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSmallButton(
                  icon: Icons.print,
                  text: AppLocalizations.of(context).translate('printReport'),
                  onTap: printPDF,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSmallButton(
                  icon: Icons.picture_as_pdf,
                  text: AppLocalizations.of(context).translate('ExportasPDF'),
                  onTap: () {
                    exportPDF(
                      context,
                    );
                  },
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
          Expanded(
            child: ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return ListTile(
                  title: Text('فاتورة رقم: ${invoice.invoiceNumber}'),
                  subtitle: Text('العميل: ${invoice.customerName}'),
                  trailing: Text('التاريخ: ${invoice.invoiceDate}'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return OrderDetails(invoice: invoice);
                      },
                    ));
                    // You can navigate to a detailed view of the invoice here if needed
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

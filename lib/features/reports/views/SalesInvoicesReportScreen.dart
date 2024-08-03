import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_constans.dart';
import 'package:pos_dashboard_v1/features/sales_bill/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';
import 'package:pos_dashboard_v1/features/sales_bill/widgets/invoice_item_detail_view.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_small_button.dart';
import '../../../l10n/app_localizations.dart';

class SalesInvoicesReportScreen extends StatefulWidget {
  const SalesInvoicesReportScreen({super.key});

  @override
  _SalesInvoicesReportScreenState createState() =>
      _SalesInvoicesReportScreenState();
}

class _SalesInvoicesReportScreenState extends State<SalesInvoicesReportScreen> {
  List<SalesInvoice> invoices = [];
  // List<ReturnInvoiceModel> returnInvoices = [];

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  Future<void> exportPDF() async {
    try {
      final pdf = await generatePDF();

      // Open file picker to let user choose where to save the file
      final result = await FilePicker.platform.saveFile(
          dialogTitle: 'Select where to save the PDF',
          fileName: 'return_invoices_report.pdf');

      if (result != null) {
        final file = File(result);
        await file.writeAsBytes(await pdf.save());

        if (await file.exists()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF saved to ${file.path}')),
          );
          // await OpenFile.open(file.path);
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

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();

    // Calculate totals

    final totalItemsReturned = invoices.length;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Return Invoices Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Invoice ID',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Order ID',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Employee',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Reason',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Return Date',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Total Back Money',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  ...invoices.map((invoice) => pw.TableRow(
                        children: [
                          pw.Text(invoice.invoiceDate.toString()),
                          pw.Text(invoice.invoiceDate),
                          // pw.Text(invoice.items ),
                          pw.Text(invoice.customerName),
                          pw.Text(invoice.invoiceNumber),
                        ],
                      )),
                  pw.TableRow(
                    children: [
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text('Total:'),
                      pw.Text(
                          RetuernInvocmentDatabaseConstants.columnTotalBackMoney
                              .toString(),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text('Total Items Returned:'),
                      pw.Text(totalItemsReturned.toString(),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
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
                  onTap: exportPDF,
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
                        return InvoiceDetailScreen(invoice: invoice);
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

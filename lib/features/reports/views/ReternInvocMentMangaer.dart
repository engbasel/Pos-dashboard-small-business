import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_detail_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoicee_form.dart';
import '../../../l10n/app_localizations.dart';

class ReternInvocMentMangaer extends StatefulWidget {
  const ReternInvocMentMangaer({super.key});

  @override
  _ReternInvocMentMangaerState createState() => _ReternInvocMentMangaerState();
}

class _ReternInvocMentMangaerState extends State<ReternInvocMentMangaer> {
  final DatabaseReturnsInvoice databaseHelper = DatabaseReturnsInvoice();
  List<ReturnInvoiceModel> returnInvoices = [];

  @override
  void initState() {
    super.initState();
    loadReturnInvoices();
  }

  Future<void> loadReturnInvoices() async {
    final loadedInvoices = await databaseHelper.getReturnInvoices();
    setState(() {
      returnInvoices = loadedInvoices;
    });
  }

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();

    // Calculate totals
    final totalBackMoney = returnInvoices.fold<double>(
      0.0,
      (sum, invoice) => sum + invoice.totalbackmony,
    );
    final totalItemsReturned = returnInvoices.length;

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
                  ...returnInvoices.map((invoice) => pw.TableRow(
                        children: [
                          pw.Text(invoice.id.toString()),
                          pw.Text(invoice.orderId),
                          pw.Text(invoice.employee),
                          pw.Text(invoice.reason),
                          pw.Text(invoice.returnDate),
                          pw.Text(invoice.totalbackmony.toString()),
                        ],
                      )),
                  pw.TableRow(
                    children: [
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text(''),
                      pw.Text('Total:'),
                      pw.Text(totalBackMoney.toString(),
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

  Future<void> exportPDF() async {
    final pdf = await generatePDF();

    // Open file picker to let user choose where to save the file
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Select where to save the PDF',
      fileName: 'return_invoices_report.pdf',
    );

    if (result != null) {
      final file = File(result);

      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
      await OpenFile.open(file.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF export canceled')),
      );
    }
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

  void showAddReturnInvoiceForm(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * .5,
            child: const ReturnInvoiceeForm(),
          ),
        );
      },
    );

    if (result == true) {
      loadReturnInvoices();
    }
  }

  void navigateToReturnInvoiceDetailScreen(ReturnInvoiceModel invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ReturnInvoiceDetailScreen(
            returnInvoice: invoice,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).translate('returnInvoices'),
            actions: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CustomSmallButton(
              //     icon: Icons.add,
              //     text: AppLocalizations.of(context).translate('addReturn'),
              //     onTap: () => showAddReturnInvoiceForm(context),
              //   ),
              // ),
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
              itemCount: returnInvoices.length,
              itemBuilder: (context, index) {
                final invoice = returnInvoices[index];
                return Container(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(6),
                  child: ListTile(
                    title: Text(
                      '${AppLocalizations.of(context).translate('invoiceId')}: ${invoice.id}',
                    ),
                    subtitle: Text(
                      '${AppLocalizations.of(context).translate('orderId')}: ${invoice.orderId}',
                    ),
                    onTap: () => navigateToReturnInvoiceDetailScreen(invoice),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pos_dashboard_v1/features/customers/database/CustomersHelper.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class ClientsReportsDietalis extends StatefulWidget {
  const ClientsReportsDietalis({super.key});

  @override
  _ClientsReportsDietalisState createState() => _ClientsReportsDietalisState();
}

class _ClientsReportsDietalisState extends State<ClientsReportsDietalis> {
  final CustomersHelper _dbHelper = CustomersHelper();
  List<Map<String, dynamic>> _clients = [];

  @override
  void initState() {
    super.initState();
    fetchClients();
  }

  Future<void> fetchClients() async {
    final clients = await _dbHelper.getCustomers();
    setState(() {
      _clients = clients;
    });
  }

  Future<void> printClientPDF(Map<String, dynamic> client) async {
    final pdf = await generateClientPDF(client);

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF sent to printer')),
    );
  }

  Future<pw.Document> generateClientPDF(Map<String, dynamic> client) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Client Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Full Name: ${client['fullName']}'),
              pw.Text('Indebtedness: ${client['indebtedness']}'),
              pw.Text('Current Account: ${client['currentAccount']}'),
              pw.Text('Notes: ${client['notes']}'),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  void showClientDialog(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('clientDetails'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        CustomSmallButton(
                          icon: Icons.print,
                          text: AppLocalizations.of(context)
                              .translate('printOrder'),
                          onTap: () => printClientPDF(client),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildDetailRow(
                        AppLocalizations.of(context).translate('fullName'),
                        client['fullName']),
                    buildDetailRow(
                        AppLocalizations.of(context).translate('indebtedness'),
                        client['indebtedness']),
                    buildDetailRow(
                        AppLocalizations.of(context)
                            .translate('currentAccount'),
                        client['currentAccount']),
                    buildDetailRow(
                        AppLocalizations.of(context).translate('notes'),
                        client['notes']),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  Future<void> printPDF() async {
    final pdf = await generatePDF();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF sent to printer')),
    );
  }

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Clients Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Full Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Indebtedness',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Current Account',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Notes',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  ..._clients.map((client) => pw.TableRow(
                        children: [
                          pw.Text(client['fullName']),
                          pw.Text(client['indebtedness']),
                          pw.Text(client['currentAccount']),
                          pw.Text(client['notes']),
                        ],
                      )),
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
    try {
      final pdf = await generatePDF();

      // Open file picker to let user choose where to save the file
      final result = await FilePicker.platform.saveFile(
          dialogTitle: 'Select where to save the PDF',
          fileName: 'clients_report.pdf');

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
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                final client = _clients[index];
                return Container(
                  color: Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(6),
                  child: ListTile(
                    title: Text(
                      '${AppLocalizations.of(context).translate('fullName')}: ${client['fullName']}',
                    ),
                    subtitle: Text(
                      '${AppLocalizations.of(context).translate('indebtedness')}: ${client['indebtedness']}',
                    ),
                    onTap: () => showClientDialog(client),
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

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFUtil {
  static Future<void> generateEmployeePdf(Map<String, dynamic> employee) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('First Name: ${employee['firstName']}'),
              pw.SizedBox(height: 8),
              pw.Text('Middle Name: ${employee['midName']}'),
              pw.SizedBox(height: 8),
              pw.Text('Last Name: ${employee['lastName']}'),
              pw.SizedBox(height: 8),
              pw.Text('Position: ${employee['position']}'),
              pw.SizedBox(height: 8),
              pw.Text('Department: ${employee['department']}'),
              pw.SizedBox(height: 8),
              pw.Text('Qualifications: ${employee['qualifications']}'),
              pw.SizedBox(height: 8),
              pw.Text('City: ${employee['city']}'),
              pw.SizedBox(height: 8),
              pw.Text(
                  'Experience in Position: ${employee['experienceInPosition']}'),
              pw.SizedBox(height: 8),
              pw.Text('Salary: ${employee['salary']}'),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: "${employee['firstName']}_${employee['lastName']}.pdf",
    );
  }
}

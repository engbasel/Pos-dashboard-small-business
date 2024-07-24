import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/settings/views/staff_overview.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/ocale_provider.dart';

void showPasswordAdminDialog(BuildContext context) {
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Password'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              // passwordController.text == 'basel'
              if (passwordController.text == '') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const staffOverview();
                    },
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Incorrect Password'),
                      content: const Text('Please enter the correct password.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      );
    },
  );
}

void showChangeLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).translate('changeLanguage')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('English'),
              onTap: () {
                Provider.of<LocaleProvider>(context, listen: false)
                    .setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('العربية'),
              onTap: () {
                Provider.of<LocaleProvider>(context, listen: false)
                    .setLocale(const Locale('ar'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

// ============================ export pdf Method ============================

// Future<void> exportAsPDF() async {
//   final pdf = pdfLib.Document();
//   pdf.addPage(
//     pdfLib.Page(
//       build: (context) => pdfLib.Column(
//         crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
//         children: [
//           pdfLib.Text('Customer Name: ${customerNameController.text}'),
//           pdfLib.Text('Date: ${invoiceDateController.text}'),
//           pdfLib.Text('Invoice Number: ${invoiceNumberController.text}'),
//           pdfLib.SizedBox(height: 12),
//           pdfLib.Text('Items:'),
//           pdfLib.SizedBox(height: 12),
//           ...items.map((item) => pdfLib.Row(
//                 mainAxisAlignment: pdfLib.MainAxisAlignment.spaceBetween,
//                 children: [
//                   pdfLib.Text(item.name),
//                   pdfLib.Text('Quantity: ${item.quantity}'),
//                   pdfLib.Text('Unit Price: \$${item.unitPrice}'),
//                   pdfLib.Text('Total: \$${item.total}'),
//                   pdfLib.Text('Discount: \$${item.discount}'),
//                 ],
//               )),
//           pdfLib.SizedBox(height: 12),
//           pdfLib.Text('Total Amount: \$${calculateTotalAmount()}'),
//           pdfLib.SizedBox(height: 12),
//           pdfLib.Text('Tax: \$20'),
//           pdfLib.SizedBox(height: 12),
//           pdfLib.Text('Grand Total: \$${calculateGrandTotal()}'),
//         ],
//       ),
//     ),
//   );

//   // Open file picker to choose the location and file name
//   final result = await FilePicker.platform.saveFile(
//     dialogTitle: 'Save PDF',
//     fileName: '${customerNameController.text}.pdf',
//     allowedExtensions: ['pdf'],
//   );

//   if (result != null) {
//     final file = File(result);
//     await file.writeAsBytes(await pdf.save());
//     print('PDF saved to ${file.path}');
//   } else {
//     print('No file selected');
//   }
// }

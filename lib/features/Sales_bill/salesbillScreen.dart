import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfLib;

class SalesBillScreen extends StatelessWidget {
  const SalesBillScreen({super.key});

  // Function to export as PDF
  void exportAsPDF(BuildContext context) {
    // Implement PDF export logic here using pdfLib
    // Example: Generate PDF document from sales bill data
    final pdf = pdfLib.Document();
    pdf.addPage(
      pdfLib.Page(
        build: (context) => pdfLib.Center(
          child: pdfLib.Text('Sales Bill PDF'),
        ),
      ),
    );

    // Save or share PDF as required
    // Example: Save PDF to device or share with other apps
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Bill'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Name: John Doe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Date: July 17, 2024',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              'Invoice Number: 12345',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            // Sales Items List
            ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: 5, // Replace with actual item count
              itemBuilder: (context, index) {
                return const Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('Product Name'),
                    subtitle:
                        Text('Quantity: 2 | Unit Price: \$50 | Total: \$100'),
                    trailing: Text('Discount: \$10'),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Total and Summary
            const Text(
              'Total Amount: \$450',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tax: \$20',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              'Grand Total: \$470',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Export as PDF button
            ElevatedButton(
              onPressed: () {
                exportAsPDF(context);
              },
              child: const Text('Export as PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

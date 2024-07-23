import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class SalesBillScreen extends StatefulWidget {
  const SalesBillScreen({super.key});

  @override
  _SalesBillScreenState createState() => _SalesBillScreenState();
}

class _SalesBillScreenState extends State<SalesBillScreen> {
  final customerNameController = TextEditingController();
  final invoiceDateController = TextEditingController();
  final invoiceNumberController = TextEditingController();
  final List<SalesItem> items = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with default values or fetch from the database
    customerNameController.text = 'John Doe';
    invoiceDateController.text = 'July 17, 2024';
    invoiceNumberController.text = '12345';
    // Add a default item for demonstration
    items.add(SalesItem('Product 1', 2, 50, 10));
  }

  Future<void> exportAsPDF() async {
    final pdf = pdfLib.Document();
    pdf.addPage(
      pdfLib.Page(
        build: (context) => pdfLib.Column(
          crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
          children: [
            pdfLib.Text('Customer Name: ${customerNameController.text}'),
            pdfLib.Text('Date: ${invoiceDateController.text}'),
            pdfLib.Text('Invoice Number: ${invoiceNumberController.text}'),
            pdfLib.SizedBox(height: 12),
            pdfLib.Text('Items:'),
            pdfLib.SizedBox(height: 12),
            ...items.map((item) => pdfLib.Row(
                  mainAxisAlignment: pdfLib.MainAxisAlignment.spaceBetween,
                  children: [
                    pdfLib.Text(item.name),
                    pdfLib.Text('Quantity: ${item.quantity}'),
                    pdfLib.Text('Unit Price: \$${item.unitPrice}'),
                    pdfLib.Text('Total: \$${item.total}'),
                    pdfLib.Text('Discount: \$${item.discount}'),
                  ],
                )),
            pdfLib.SizedBox(height: 12),
            pdfLib.Text('Total Amount: \$${calculateTotalAmount()}'),
            pdfLib.SizedBox(height: 12),
            pdfLib.Text('Tax: \$20'),
            pdfLib.SizedBox(height: 12),
            pdfLib.Text('Grand Total: \$${calculateGrandTotal()}'),
          ],
        ),
      ),
    );

    // Open file picker to choose the location and file name
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: '${customerNameController.text}.pdf',
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = File(result);
      await file.writeAsBytes(await pdf.save());
      print('PDF saved to ${file.path}');
    } else {
      print('No file selected');
    }
  }

  double calculateTotalAmount() {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  double calculateGrandTotal() {
    return calculateTotalAmount() + 20; // Assuming a fixed tax for now
  }

  void addItem() {
    setState(() {
      items.add(SalesItem('', 1, 0, 0));
    });
  }

  void editItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final item = items[index];
        final nameController = TextEditingController(text: item.name);
        final quantityController =
            TextEditingController(text: item.quantity.toString());
        final unitPriceController =
            TextEditingController(text: item.unitPrice.toString());
        final discountController =
            TextEditingController(text: item.discount.toString());

        return AlertDialog(
          title: const Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: unitPriceController,
                decoration: const InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: discountController,
                decoration: const InputDecoration(labelText: 'Discount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedItem = SalesItem(
                  nameController.text,
                  int.parse(quantityController.text),
                  double.parse(unitPriceController.text),
                  double.parse(discountController.text),
                );
                setState(() {
                  items[index] = updatedItem;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
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
            TextFormField(
              controller: customerNameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: invoiceDateController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: invoiceNumberController,
              decoration: const InputDecoration(labelText: 'Invoice Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            // Sales Items List
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                        'Quantity: ${item.quantity} | Unit Price: \$${item.unitPrice} | Total: \$${item.total}'),
                    trailing: Text('Discount: \$${item.discount}'),
                    onTap: () {
                      editItem(index);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Total and Summary
            Text(
              'Total Amount: \$${calculateTotalAmount()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tax: \$20',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Grand Total: \$${calculateGrandTotal()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Add Item Button
            ElevatedButton(
              onPressed: addItem,
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 12),
            // Export as PDF button
            ElevatedButton(
              onPressed: exportAsPDF,
              child: const Text('Export as PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesItem {
  SalesItem(this.name, this.quantity, this.unitPrice, this.discount)
      : total = quantity * unitPrice - discount;

  final String name;
  final int quantity;
  final double unitPrice;
  final double discount;
  late final double total;
}

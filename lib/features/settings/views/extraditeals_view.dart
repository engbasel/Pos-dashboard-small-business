import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ExtraditealsScreen extends StatefulWidget {
  final Map<String, dynamic> employee;

  const ExtraditealsScreen({super.key, required this.employee});

  @override
  State<ExtraditealsScreen> createState() => _ExtraditealsScreenState();
}

class _ExtraditealsScreenState extends State<ExtraditealsScreen> {
  late double salary;
  late double incentives;
  late double taxes;
  late double discounts;
  late double overtime;
  late double absence;
  late double healthInsurance;
  late double socialInsurance;
  late double employeeDamage;

  @override
  void initState() {
    super.initState();
    salary = widget.employee['salary']?.toDouble() ?? 0.0;
    incentives = widget.employee['incentives']?.toDouble() ?? 0.0;
    taxes = 0.0;
    discounts = 0.0;
    overtime = 0.0;
    absence = 0.0;
    healthInsurance = widget.employee['healthInsurance']?.toDouble() ?? 0.0;
    socialInsurance = widget.employee['socialInsurance']?.toDouble() ?? 0.0;
    employeeDamage = 0.0;
  }

  void _updateSalary() {
    double newSalary = salary +
        incentives -
        taxes -
        discounts +
        overtime -
        absence -
        healthInsurance -
        socialInsurance -
        employeeDamage;
    setState(() {
      salary = newSalary;
    });
  }

  Future<void> _exportPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildTextRow('Current Salary:', salary.toStringAsFixed(2)),
              _buildTextRow('Incentives:', incentives.toStringAsFixed(2)),
              _buildTextRow('Taxes:', taxes.toStringAsFixed(2)),
              _buildTextRow('Discounts:', discounts.toStringAsFixed(2)),
              _buildTextRow('Overtime:', overtime.toStringAsFixed(2)),
              _buildTextRow('Absence:', absence.toStringAsFixed(2)),
              _buildTextRow(
                  'Health Insurance:', healthInsurance.toStringAsFixed(2)),
              _buildTextRow(
                  'Social Insurance:', socialInsurance.toStringAsFixed(2)),
              _buildTextRow(
                  'Employee Damage:', employeeDamage.toStringAsFixed(2)),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename:
          "${widget.employee['firstName']}_${widget.employee['lastName']}_details.pdf",
    );
  }

  pw.Widget _buildTextRow(String label, String value) {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(width: 8),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extra Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _exportPdf,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Salary: ${salary.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Table(
              border: TableBorder.all(),
              children: [
                _buildEditableRow('Incentives', incentives,
                    (value) => incentives = value, 'Incentives'),
                _buildEditableRow(
                    'Taxes', taxes, (value) => taxes = value, 'Taxes'),
                _buildEditableRow('Discounts', discounts,
                    (value) => discounts = value, 'Discounts'),
                _buildEditableRow('Overtime', overtime,
                    (value) => overtime = value, 'Overtime'),
                _buildEditableRow(
                    'Absence', absence, (value) => absence = value, 'Absence'),
                _buildEditableRow('Health Insurance', healthInsurance,
                    (value) => healthInsurance = value, 'Health Insurance'),
                _buildEditableRow('Social Insurance', socialInsurance,
                    (value) => socialInsurance = value, 'Social Insurance'),
                _buildEditableRow('Employee Damage', employeeDamage,
                    (value) => employeeDamage = value, 'Employee Damage'),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateSalary,
              child: const Text('Update Salary'),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildEditableRow(String label, double value,
      ValueChanged<double> onChanged, String cellName) {
    return TableRow(
      children: [
        GestureDetector(
          // onTap: () => _onCellTap(cellName),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GestureDetector(
          // onTap: () => _onCellTap(cellName),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: value.toString(),
              keyboardType: TextInputType.number,
              onChanged: (newValue) {
                double parsedValue = double.tryParse(newValue) ?? 0.0;
                onChanged(parsedValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}

// class IncentivesScreen extends StatelessWidget {
//   const IncentivesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Incentives'),
//       ),
//       body: const Center(
//         child: Text('Incentives details go here'),
//       ),
//     );
//   }
// }

// class TaxesScreen extends StatelessWidget {
//   const TaxesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Taxes'),
//       ),
//       body: const Center(
//         child: Text('Taxes details go here'),
//       ),
//     );
//   }
// }

// class DiscountsScreen extends StatelessWidget {
//   const DiscountsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Discounts'),
//       ),
//       body: const Center(
//         child: Text('Discounts details go here'),
//       ),
//     );
//   }
// }

// class OvertimeScreen extends StatelessWidget {
//   const OvertimeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Overtime'),
//       ),
//       body: const Center(
//         child: Text('Overtime details go here'),
//       ),
//     );
//   }
// }

// class AbsenceScreen extends StatelessWidget {
//   const AbsenceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Absence'),
//       ),
//       body: const Center(
//         child: Text('Absence details go here'),
//       ),
//     );
//   }
// }

// class HealthInsuranceScreen extends StatelessWidget {
//   const HealthInsuranceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Health Insurance'),
//       ),
//       body: const Center(
//         child: Text('Health Insurance details go here'),
//       ),
//     );
//   }
// }

// class SocialInsuranceScreen extends StatelessWidget {
//   const SocialInsuranceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Social Insurance'),
//       ),
//       body: const Center(
//         child: Text('Social Insurance details go here'),
//       ),
//     );
//   }
// }

// class EmployeeDamageScreen extends StatelessWidget {
//   const EmployeeDamageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee Damage'),
//       ),
//       body: const Center(
//         child: Text('Employee Damage details go here'),
//       ),
//     );
//   }
// }
  // void _onCellTap(String cellName) {
  //   switch (cellName) {
  //     case 'Incentives':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const IncentivesScreen()),
  //       );
  //       break;
  //     case 'Taxes':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const TaxesScreen()),
  //       );
  //       break;
  //     case 'Discounts':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const DiscountsScreen()),
  //       );
  //       break;
  //     case 'Overtime':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const OvertimeScreen()),
  //       );
  //       break;
  //     case 'Absence':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const AbsenceScreen()),
  //       );
  //       break;
  //     case 'Health Insurance':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => const HealthInsuranceScreen()),
  //       );
  //       break;
  //     case 'Social Insurance':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => const SocialInsuranceScreen()),
  //       );
  //       break;
  //     case 'Employee Damage':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const EmployeeDamageScreen()),
  //       );
  //       break;
  //   }
  // }
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/client/database/CustomersHelper.dart';
import 'package:pos_dashboard_v1/features/client/widgets/customer_detail_view.dart';

class CustomerDetailPage extends StatefulWidget {
  final int customerId;

  const CustomerDetailPage({required this.customerId, super.key});

  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  late Future<Map<String, dynamic>?> _customer;

  @override
  void initState() {
    super.initState();
    _customer = _fetchCustomer();
  }

  Future<Map<String, dynamic>?> _fetchCustomer() async {
    final customersHelper = CustomersHelper();
    return await customersHelper.getCustomerById(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _customer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Customer not found'));
          } else {
            final customer = snapshot.data!;
            return CustomerDetailView(customer: customer);
          }
        },
      ),
    );
  }
}

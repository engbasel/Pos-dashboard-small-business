import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/customers/database/customers_helper.dart';
import 'package:pos_dashboard_v1/features/customers/widgets/customer_detail_view.dart';

class CustomerDetailsView extends StatefulWidget {
  final int customerId;

  const CustomerDetailsView({required this.customerId, super.key});

  @override
  State<CustomerDetailsView> createState() => _CustomerDetailsViewState();
}

class _CustomerDetailsViewState extends State<CustomerDetailsView> {
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

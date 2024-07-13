import 'package:flutter/material.dart';

import '../../../core/db/clients_database.dart';
import '../widgets/AddCustomerDialog.dart';
import '../widgets/CostomCoustomDitelsCard.dart';
import '../widgets/CustomerDetailView.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  _CustomersViewState createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  final Customers_helper dbHelper = Customers_helper();
  List<Map<String, dynamic>> customers = [];
  List<Map<String, dynamic>> filteredCustomers = [];
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchCustomers();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        filterCustomers();
      });
    });
  }

  Future<void> fetchCustomers() async {
    List<Map<String, dynamic>> fetchedCustomers = await dbHelper.getCustomers();
    setState(() {
      customers = fetchedCustomers;
      filteredCustomers = customers;
    });
  }

  void addCustomer(Map<String, String> customer) async {
    await dbHelper.insertCustomer(customer);
    fetchCustomers();
  }

  void updateCustomer(Map<String, String> customer) async {
    await dbHelper.updateCustomer(customer);
    fetchCustomers();
  }

  void deleteCustomer(int id) async {
    await dbHelper.deleteCustomer(id);
    fetchCustomers();
  }

  void filterCustomers() {
    setState(() {
      if (searchQuery.isEmpty) {
        filteredCustomers = customers;
      } else {
        filteredCustomers = customers
            .where((customer) => customer['fullName']
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredCustomers.isEmpty
                ? const Center(child: Text('Client not found'))
                : ListView(
                    children: filteredCustomers
                        .map((customer) => CostomCoustomDitelsCard(
                              customer: customer,
                              onEdit: updateCustomer,
                              onDelete: deleteCustomer,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CustomerDetailView(
                                    customer: customer,
                                    onEdit: updateCustomer,
                                    onDelete: deleteCustomer,
                                  ),
                                ));
                              },
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCustomer = await showDialog<Map<String, String>>(
            context: context,
            builder: (context) => const AddCustomerDialog(),
          );
          if (newCustomer != null) {
            addCustomer(newCustomer);
          }
        },
        tooltip: 'Add Customer',
        child: const Icon(Icons.add),
      ),
    );
  }
}

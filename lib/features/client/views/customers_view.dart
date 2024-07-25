import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/client/widgets/custom_details_card.dart';
import '../../../core/db/clients_database.dart';
import '../widgets/add_customer_dialog.dart';
import '../widgets/customer_detail_view.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
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
      filterCustomers();
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
        filteredCustomers = List.from(customers);
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
      backgroundColor: Colors.white,
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
                : ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];
                      return CustomDetailsCard(
                        customer: customer,
                        onEdit: (editedCustomer) {
                          updateCustomer(editedCustomer);
                        },
                        onDelete: (id) {
                          deleteCustomer(id);
                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomerDetailView(
                              customer: customer,
                              onEdit: (editedCustomer) {
                                updateCustomer(editedCustomer);
                              },
                              onDelete: (id) {
                                deleteCustomer(id);
                              },
                            ),
                          ));
                        },
                      );
                    },
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
        backgroundColor: const Color(0xff4985FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

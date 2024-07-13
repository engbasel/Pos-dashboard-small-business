import 'package:flutter/material.dart';

import '../../../core/db/clients_database.dart';

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
  final database = Customers_helper(); // Initialize your database helper

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
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomerSearchDelegate(
                  customers: customers,
                  onQueryUpdate: (query) {
                    searchController.text = query;
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      body: filteredCustomers.isEmpty
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
                      }))
                  .toList(),
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

class CostomCoustomDitelsCard extends StatelessWidget {
  final Map<String, dynamic> customer;
  final Function(Map<String, String>) onEdit;
  final Function(int) onDelete;
  final VoidCallback onTap;

  const CostomCoustomDitelsCard({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name: ${customer['fullName']}',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Indebtedness: ${customer['indebtedness']}'),
              Text('Current Account: ${customer['currentAccount']}'),
              Text('Notes: ${customer['notes']}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      // Implement edit functionality here
                    },
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirm Delete'),
                          content: const Text(
                              'Are you sure you want to delete this customer?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                onDelete(customer['id']);
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> customers;
  final Function(String) onQueryUpdate;

  CustomerSearchDelegate(
      {required this.customers, required this.onQueryUpdate});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onQueryUpdate(query);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = customers
        .where((customer) =>
            customer['fullName'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('Client not found'),
      );
    }

    return ListView(
      children: results
          .map((customer) => CostomCoustomDitelsCard(
                customer: customer,
                onEdit: (customer) {},
                onDelete: (id) {},
                onTap: () {},
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryUpdate(query);

    final suggestions = customers
        .where((customer) =>
            customer['fullName'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map((customer) => ListTile(
                title: Text(customer['fullName']),
                onTap: () {
                  query = customer['fullName'];
                  showResults(context);
                },
              ))
          .toList(),
    );
  }
}

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  @override
  _AddCustomerDialogState createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _customerData = {
    'fullName': '',
    'indebtedness': '',
    'currentAccount': '',
    'notes': ''
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
                onSaved: (value) => _customerData['fullName'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Indebtedness'),
                onSaved: (value) => _customerData['indebtedness'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Account'),
                onSaved: (value) => _customerData['currentAccount'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                onSaved: (value) => _customerData['notes'] = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(_customerData);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class CustomerDetailView extends StatelessWidget {
  final Map<String, dynamic> customer;
  final Function(Map<String, String>) onEdit;
  final Function(int) onDelete;

  const CustomerDetailView({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        actions: [
          IconButton(
            onPressed: () async {
              final updatedCustomer = await showDialog<Map<String, String>>(
                context: context,
                builder: (context) => EditCustomerDialog(customer: customer),
              );
              if (updatedCustomer != null) {
                onEdit(updatedCustomer);
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text(
                      'Are you sure you want to delete this customer?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        onDelete(customer['id']);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name: ${customer['fullName']}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Indebtedness: ${customer['indebtedness']}'),
            Text('Current Account: ${customer['currentAccount']}'),
            Text('Notes: ${customer['notes']}'),
          ],
        ),
      ),
    );
  }
}

class EditCustomerDialog extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerDialog({required this.customer, super.key});

  @override
  _EditCustomerDialogState createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _customerData;

  @override
  void initState() {
    super.initState();
    _customerData = Map<String, String>.from(widget.customer);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: _customerData['fullName'],
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
                onSaved: (value) => _customerData['fullName'] = value!,
              ),
              TextFormField(
                initialValue: _customerData['indebtedness'],
                decoration: const InputDecoration(labelText: 'Indebtedness'),
                onSaved: (value) => _customerData['indebtedness'] = value!,
              ),
              TextFormField(
                initialValue: _customerData['currentAccount'],
                decoration: const InputDecoration(labelText: 'Current Account'),
                onSaved: (value) => _customerData['currentAccount'] = value!,
              ),
              TextFormField(
                initialValue: _customerData['notes'],
                decoration: const InputDecoration(labelText: 'Notes'),
                onSaved: (value) => _customerData['notes'] = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(_customerData);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

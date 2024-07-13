import 'package:flutter/material.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  _CustomersViewState createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  List<Map<String, String>> customers = [];
  List<Map<String, String>> filteredCustomers = [];
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredCustomers = customers;
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
        filterCustomers();
      });
    });
  }

  void addCustomer(Map<String, String> customer) {
    setState(() {
      customers.add(customer);
      filterCustomers();
    });
  }

  void filterCustomers() {
    setState(() {
      if (searchQuery.isEmpty) {
        filteredCustomers = customers;
      } else {
        filteredCustomers = customers
            .where((customer) => customer['fullName']!
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
                  .map(
                      (customer) => CostomCoustomDitelsCard(customer: customer))
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
  final Map<String, String> customer;

  const CostomCoustomDitelsCard({required this.customer, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    // Implement delete functionality here
                  },
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
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
            _formKey.currentState?.save();
            Navigator.of(context).pop(_customerData);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class CustomerSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> customers;
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
            customer['fullName']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('Client not found'),
      );
    }

    return ListView(
      children: results
          .map((customer) => CostomCoustomDitelsCard(customer: customer))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryUpdate(query);

    final suggestions = customers
        .where((customer) =>
            customer['fullName']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map((customer) => ListTile(
                title: Text(customer['fullName']!),
                onTap: () {
                  query = customer['fullName']!;
                  showResults(context);
                },
              ))
          .toList(),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CustomersView(),
  ));
}

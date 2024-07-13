import 'package:flutter/material.dart';

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

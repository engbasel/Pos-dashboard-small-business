import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/customers/database/customers_helper.dart';
import 'package:pos_dashboard_v1/features/customers/widgets/custom_details_card.dart';
import '../widgets/add_customer_dialog.dart';
import '../widgets/customer_detail_view.dart';
import '../../../l10n/app_localizations.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  final CustomersHelper dbHelper = CustomersHelper();
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
    try {
      List<Map<String, dynamic>> fetchedCustomers =
          await dbHelper.getCustomers();
      setState(() {
        customers = fetchedCustomers;
        filterCustomers();
      });
    } catch (e) {
      print('Error fetching customers: $e');
      // Handle the error appropriately (e.g., show an error message)
    }
  }

  Future<void> addCustomer(Map<String, dynamic> customer) async {
    try {
      await dbHelper.insertCustomer(customer);
      fetchCustomers();
    } catch (e) {
      print('Error adding customer: $e');
      // Handle the error appropriately
    }
  }

  Future<void> updateCustomer(Map<String, dynamic> customer) async {
    try {
      await dbHelper.updateCustomer(customer);
      fetchCustomers();
    } catch (e) {
      print('Error updating customer: $e');
      // Handle the error appropriately
    }
  }

  Future<void> deleteCustomer(int id) async {
    try {
      await dbHelper.deleteCustomer(id);
      fetchCustomers();
    } catch (e) {
      print('Error deleting customer: $e');
      // Handle the error appropriately
    }
  }

  void filterCustomers() {
    setState(() {
      if (searchQuery.isEmpty) {
        filteredCustomers = List.from(customers);
      } else {
        filteredCustomers = customers
            .where((customer) =>
                customer['name'] // Ensure 'name' is the correct key
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> showCustomerDetailsDialog(Map<String, dynamic> customer) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: CustomerDetailView(customer: customer),
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('customers'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              text: AppLocalizations.of(context).translate('addCustomer'),
              onTap: () async {
                final newCustomer = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) =>
                      AddCustomerDialog(customersHelper: dbHelper),
                );
                if (newCustomer != null) {
                  await addCustomer(newCustomer);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context).translate('searchCustomer'),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: filteredCustomers.isEmpty
                ? const Center(
                    child: Text(''),
                  )
                : ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];
                      return CustomDetailsCard(
                        customer: customer,
                        onEdit: (editedCustomer) async {
                          await updateCustomer(editedCustomer);
                        },
                        onDelete: (id) async {
                          await deleteCustomer(id);
                        },
                        onTap: () {
                          showCustomerDetailsDialog(customer);
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

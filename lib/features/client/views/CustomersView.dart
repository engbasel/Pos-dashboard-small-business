import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/client/widgets/custom_details_card.dart';
import '../database/CustomersHelper.dart';
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

  Future<dynamic> userdiloageData(
      BuildContext context, Map<String, dynamic> customer) {
    return showDialog(
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
  // void dispose() {
  //   searchController.dispose();
  //       super.dispose();
  // }

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
                final newCustomer = await showDialog<Map<String, String>>(
                  context: context,
                  builder: (context) => const AddCustomerDialog(),
                );
                if (newCustomer != null) {
                  addCustomer(newCustomer);
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
              decoration: const InputDecoration(
                hintText: 'Search for a customer...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
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
                ? const Center(child: Text(''))
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
                          userdiloageData(context, customer);
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

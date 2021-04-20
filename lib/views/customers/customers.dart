import 'package:flutter/material.dart';
import 'package:flutter_crud_with_firestore_app/locator.dart';
import 'package:flutter_crud_with_firestore_app/models/customer.dart';
import 'package:flutter_crud_with_firestore_app/services/authentification_service.dart';
import 'package:flutter_crud_with_firestore_app/services/firestore_customer_service.dart';
import 'package:flutter_crud_with_firestore_app/views/customers/customer.dart';
import 'package:provider/provider.dart';

class CustomersView extends StatefulWidget {
  @override
  _CustomersViewState createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  late Stream<List<Customer>> _customersStream;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _customersStream = locator<FirestoreCustomerService>().getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildButtonAdd(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Customers'),
      actions: [
        buildButtonLogout(),
      ],
    );
  }

  Widget buildButtonLogout() {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: _logout,
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        buildCustomers(),
        buildError(),
      ],
    );
  }

  Widget buildCustomers() {
    return Expanded(
      child: StreamBuilder(
        stream: _customersStream,
        builder: (context, AsyncSnapshot<List<Customer>> snapshot) {
          if (snapshot.hasError) {
            _error = snapshot.error.toString();
            return Container();
          }

          _error = '';
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<Customer> customers = snapshot.data ?? [];
          return ListView.builder(
            shrinkWrap: true,
            itemCount: customers.length,
            itemBuilder: (context, index) {
              Customer customer = customers[index];
              return buildCustomer(customer);
            },
          );
        },
      ),
    );
  }

  Widget buildCustomer(Customer customer) {
    return ListTile(
      title: Text(customer.name),
      subtitle: Text(customer.age.toString() + " year(s)"),
      onTap: () => _editCustomer(customer),
    );
  }

  Widget buildError() {
    return Text(_error);
  }

  Widget buildButtonAdd() {
    return FloatingActionButton(
      onPressed: () => _editCustomer(null),
      child: Icon(Icons.add),
    );
  }

  _editCustomer(Customer? customer) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerView(customer: customer)));
  }

  _logout() async {
    String error = await context.read<AuthentificationService>().signOut();

    if (error.isNotEmpty) {
      setState(() => _error = error);
    }
  }
}

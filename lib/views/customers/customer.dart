import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_with_firestore_app/locator.dart';
import 'package:flutter_crud_with_firestore_app/models/customer.dart';
import 'package:flutter_crud_with_firestore_app/services/firestore_customer_service.dart';

class CustomerView extends StatefulWidget {
  final Customer? customer;

  const CustomerView({Key? key, this.customer}) : super(key: key);

  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  late Customer _customer;
  String _error = '';

  @override
  void initState() {
    super.initState();

    _customer = widget.customer ?? Customer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(title: Text('Customer'));
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            buildName(),
            buildAge(),
            buildError(),
            buildButtonValidate(),
          ],
        ),
      ),
    );
  }

  Widget buildName() {
    return TextFormField(
      initialValue: _customer.name,
      onChanged: (value) => _customer.name = value,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildAge() {
    return TextFormField(
      initialValue: _customer.age.toString(),
      onChanged: (value) => _customer.age = int.parse(value),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: 'Age'),
    );
  }

  Widget buildError() {
    return Text(_error);
  }

  Widget buildButtonValidate() {
    return TextButton(
      onPressed: _validate,
      child: Text('Validate'),
    );
  }

  _validate() async {
    if (_customer.id.isEmpty) {
      await locator<FirestoreCustomerService>().addCustomer(_customer);
    } else {
      await locator<FirestoreCustomerService>().setCustomer(_customer);
    }

    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_crud_with_firestore_app/services/authentification_service.dart';
import 'package:provider/provider.dart';

class ResetView extends StatefulWidget {
  @override
  _ResetViewState createState() => _ResetViewState();
}

class _ResetViewState extends State<ResetView> {
  String _email = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Reset password'),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            buildEmail(),
            buildButtonReset(),
            buildError(),
          ],
        ),
      ),
    );
  }

  Widget buildEmail() {
    return TextFormField(
      onChanged: (value) => _email = value,
      decoration: InputDecoration(hintText: 'Email'),
    );
  }

  Widget buildButtonReset() {
    return TextButton(
      onPressed: _reset,
      child: Text('Reset password'),
    );
  }

  Widget buildError() {
    return Text(_error);
  }

  _reset() async {
    String error = await context.read<AuthentificationService>().sendPasswordResetEmail(
          email: _email.trim(),
        );

    setState(() => _error = error);
  }
}

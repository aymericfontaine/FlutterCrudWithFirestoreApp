import 'package:flutter_crud_with_firestore_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_with_firestore_app/services/authentification_service.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(title: Text('Register'));
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            buildEmail(),
            buildPassword(),
            buildError(),
            buildButtonRegister(),
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

  Widget buildPassword() {
    return TextFormField(
      onChanged: (value) => _password = value,
      obscureText: true,
      decoration: InputDecoration(hintText: 'Password'),
    );
  }

  Widget buildError() {
    return Text(_error);
  }

  Widget buildButtonRegister() {
    return TextButton(
      onPressed: _register,
      child: Text('Register'),
    );
  }

  _register() async {
    String error = await context.read<AuthentificationService>().createUserWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );

    if (error.isNotEmpty) {
      setState(() => _error = error);
    }
  }
}

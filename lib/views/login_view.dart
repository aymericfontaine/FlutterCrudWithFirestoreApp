import 'package:flutter_crud_with_firestore_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_with_firestore_app/services/authentification_service.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return AppBar(title: Text('Login'));
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
            buildButtonLogin(),
            buildButtonReset(),
            buildButtonRegister(),
          ],
        ),
      ),
    );
  }

  Widget buildEmail() {
    return TextFormField(
      onChanged: (value) => _email = value,
      decoration: InputDecoration(labelText: 'Email'),
    );
  }

  Widget buildPassword() {
    return TextFormField(
      onChanged: (value) => _password = value,
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
    );
  }

  Widget buildError() {
    return Text(_error);
  }

  Widget buildButtonLogin() {
    return TextButton(
      onPressed: _login,
      child: Text('Login'),
    );
  }

  Widget buildButtonReset() {
    return TextButton(
      onPressed: _reset,
      child: Text('Reset password'),
    );
  }

  Widget buildButtonRegister() {
    return TextButton(
      onPressed: _register,
      child: Text('Register'),
    );
  }

  _login() async {
    String error = await context.read<AuthentificationService>().signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );

    if (error.isNotEmpty) {
      setState(() => _error = error);
    }
  }

  _reset() async {
    await Navigator.pushNamed(context, RouteGenerater.kRouteReset);
  }

  _register() async {
    await Navigator.pushNamed(context, RouteGenerater.kRouteRegister);
  }
}

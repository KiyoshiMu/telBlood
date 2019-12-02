import 'package:flutter/material.dart';
import 'package:telblood/bloc/login_bloc.dart';
import 'package:telblood/services/authentication.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }

  @override
    void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar( bottom: PreferredSize(
      child: Icon(
        Icons.account_circle,
        size: 88.0,
        color: Colors.white,
      ),
      preferredSize: Size.fromHeight(40.0)),
      ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _loginBloc.email,
              builder: (BuildContext context, AsyncSnapshot
                snapshot) => TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                  labelText: 'Email Address',
                icon: Icon(Icons.mail_outline),
                errorText: snapshot.error),
                onChanged: _loginBloc.emailChanged.add,
              ),
            ),
            StreamBuilder(
              stream: _loginBloc.password,
              builder: (BuildContext context, AsyncSnapshot
                snapshot) =>
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                labelText: 'Password',
                icon:
                  Icon(Icons.security),
                  errorText: snapshot.error),
                onChanged: _loginBloc.passwordChanged.add,
              ),
            ),
            SizedBox(height: 48.0),
          ],
          ),
        ),
      ),
    );
  }
}
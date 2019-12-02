import 'package:telblood/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telblood/pages/login.dart';
import 'package:telblood/pages/dashboard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, UserRepository user, _) {
      switch (user.status) {
        case Status.Uninitialized:
        // return Splash();
        case Status.Unauthenticated:
        // return Splash();
        case Status.Authenticating:
          return LoginPage();
        case Status.Authenticated:
          return Dashboard(user: user.user);
        default:
          return Splash();
      }
    });
  }
}


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}

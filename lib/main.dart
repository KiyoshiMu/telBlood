import 'package:flutter/material.dart';
import 'package:telblood/pages/home.dart';
import 'services/auth.dart';
import 'services/sensors.dart';
import 'package:provider/provider.dart';

void main() => runApp(TelBloodApp());

class TelBloodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserRepository.instance()),
            ChangeNotifierProxyProvider<UserRepository, Sensors>(
              create: (_) => Sensors(),
              update: (_, user, sensors) => Sensors(user: user),
            )
          ],
          child: MaterialApp(
              theme: ThemeData(primarySwatch: Colors.red), home: HomePage()));
}

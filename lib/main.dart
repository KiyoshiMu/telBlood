import 'package:flutter/material.dart';
import 'package:telblood/pages/home.dart';
import 'package:telblood/models/config.dart';

void main() => runApp(GluApp());

class GluApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Configs(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red
        ),
        home: HomePage(),
    ),
  );
}
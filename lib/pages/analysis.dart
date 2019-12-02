import 'package:flutter/material.dart';
import 'package:telblood/widgets/share.dart';

class AnalysisPage extends StatelessWidget {
  final double result;
  AnalysisPage(this.result);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Analysis'),
      // centerTitle: true,
    ),
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/sugar.jpg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '${result.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20),
              child: Text(
                "Normal value ranges may vary slightly among different laboratories.\n"
                "You stay in the Normal range most of the time\n"
                "Good Job!"
                ,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Share(),
          ],
        ),
      ),
    ),
  );
}
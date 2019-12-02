import 'package:flutter/material.dart';
import 'package:telblood/models/sensor.dart';
import 'package:telblood/models/config.dart';

class OverView extends StatelessWidget {
  final String type;

  OverView({
    this.type,
    Key key, 
    }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    String title;
    String unit;
    Stream stream;
    switch (this.type) {
      case 'Glucose': {
        title = Configs.of(context).gluConfig.title;
        unit = Configs.of(context).gluConfig.unit;
        stream = Configs.of(context).gluConfig.recorder.flowin;
      }
      break;
      default: {
        title = Configs.of(context).bpConfig.title;
        unit = Configs.of(context).bpConfig.unit;
        stream = Configs.of(context).bpConfig.recorder.flowin;
      }
    }
    
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        // bottom: 15,
        left: 30,
        right: 30
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              Text(
                unit
              )
            ],
          ),
          buildStreamBuilder(stream),
          ],
        ),
      );
  }
  StreamBuilder<Object> buildStreamBuilder(stream) {
    return StreamBuilder<Object>(
      stream: stream,
      initialData: 100.0,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Error');
        }
        TimeSeriesPoint data = snapshot.data;
        return Text(
          data.value.toStringAsFixed(2),
          style: TextStyle(
            color: Colors.lightGreen,
            fontSize: 40,
            fontWeight: FontWeight.bold
          ),
        );
      }
    );
  }
}
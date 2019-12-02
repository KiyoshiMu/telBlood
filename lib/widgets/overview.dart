import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telblood/models/sensor.dart';
import 'package:telblood/services/sensors.dart';

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
        title = Provider.of<Sensors>(context).gluConfig.title;
        unit = Provider.of<Sensors>(context).gluConfig.unit;
        stream = Provider.of<Sensors>(context).gluConfig.recorder.flowin;
      }
      break;
      default: {
        title = Provider.of<Sensors>(context).bpConfig.title;
        unit = Provider.of<Sensors>(context).bpConfig.unit;
        stream = Provider.of<Sensors>(context).bpConfig.recorder.flowin;
      }
    }
    
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        // bottom: 15,
        left: 30,
        right: 30
        ),
      width: MediaQuery.of(context).size.width * 0.95,
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
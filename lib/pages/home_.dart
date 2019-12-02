import 'package:flutter/material.dart';
import 'package:telblood/pages/detail.dart';
import 'package:telblood/widgets/overview.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _view = [];

  void _updateItems(int oldIndex, int newIndex) {
      if(newIndex > oldIndex){
        newIndex -= 1;
      }
      Future.delayed(Duration(milliseconds: 20), () {
        setState(() {
          final Widget item = _view.removeAt(oldIndex);
          _view.insert(newIndex, item);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _view
      ..add(
        gestureDetector('Glucose'))
      ..add(
        gestureDetector('Blood Pressure'));
      //   OverView(
      //     key: UniqueKey(),
      //     title: 'Blood Pressure', 
      //     unit: 'mmHg', 
      //     initVal: 100,))
      // ..add(
      //   OverView(
      //     key: UniqueKey(),
      //     title: 'Heart Rate', 
      //     unit: 'BPM',  
      //     initVal: 50,));
  }

  GestureDetector gestureDetector(String type) {
    return GestureDetector(
        key: UniqueKey(), 
        child: OverView(
          type: type,),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => DataPage(
              type)
            )
          );
        },
      );
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('TelBlood'),
      centerTitle: true,
    ),
    body: SafeArea(
      child: ReorderableListView(
        children: _view,
        onReorder: (oldIndex, newIndex) {
          _updateItems(oldIndex, newIndex);
        }
      ),
    ),
  );
}
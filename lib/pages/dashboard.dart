import 'package:flutter/material.dart';
import 'package:telblood/pages/detail.dart';
import 'package:telblood/widgets/overview.dart';
import 'package:telblood/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telblood/widgets/userinfo.dart';

class Dashboard extends StatefulWidget {
  final FirebaseUser user;
  Dashboard({Key key, this.user}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    endDrawer: UserDrawer(user: widget.user,),
    body: SafeArea(
      child: ReorderableListView(
        children: _view,
        onReorder: (oldIndex, newIndex) {
          _updateItems(oldIndex, newIndex);
        }
      ),
    ),
    bottomNavigationBar: BottomAppBar(
      child: IconButton(
        icon: Icon(
          Icons.exit_to_app
        ),
        onPressed: () => Provider.of<UserRepository>(context).signOut(),
      ),
    ),
  );
}
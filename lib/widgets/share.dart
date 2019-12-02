import 'package:flutter/material.dart';
import 'package:telblood/pages/contact.dart';

class Share extends StatelessWidget {

  void _toContact(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ContactPage()
    ));
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    child: Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20), 
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.share,
              size: 33,
            ),
          ),
          Text(
            'Share',
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      _toContact(context);
    },
  );
}
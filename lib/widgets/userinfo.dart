import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDrawer extends StatelessWidget {
  final FirebaseUser user;
  const UserDrawer({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset(
                'assets/images/trump.png',
                width: 40,
              ),
              accountName: Text(this.user.displayName ?? ''),
              accountEmail: Text(this.user.email ?? ''),
              otherAccountsPictures: <Widget>[
                Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                )
              ]),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Daily Note',
              style: TextStyle(
                fontSize: 33,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'A beautiful wall and a beautiful phone-call keep doctors away.',
              style: TextStyle(
                fontSize: 22,
              ),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}

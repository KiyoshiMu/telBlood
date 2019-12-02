import 'package:flutter/material.dart';

const List<IconData> icons = [Icons.ac_unit, 
    Icons.shopping_cart, 
    Icons.wb_sunny,
    Icons.mood,
    Icons.filter_drama
    ];

const List<String> users = [
     "Dr.One",
     "Dr.Two",
     "Dr.Three",
     "Dr.Four",
     "Dr.Five"
  ];

class ContactPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Contact'),
      // centerTitle: true,
    ),
    body: SafeArea(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, idx) => ListTile(
          title: Text(
            users[idx],
          ),
          leading: Icon(icons[idx]),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ChatWidget(
            //       name: users[idx], 
            //       icon: icons[(idx%5).toInt()])
            //   )
            // );
          },
        ),
      )
    ),
  );
}
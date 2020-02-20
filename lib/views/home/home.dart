import 'package:flutter/material.dart';
import 'package:zzeater/services/auth.dart';
import 'package:zzeater/services/database.dart';
import 'package:provider/provider.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zzeater/views/home/profile-pic/profile-pic.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  final String userFirstName;
  final String userLastName;
  final String userProfilePicUrl;

  Home({this.userFirstName, this.userLastName, this.userProfilePicUrl});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().users,
        child: Scaffold(
        backgroundColor: Colors.red[700],
        body: Container(
          child: Column(
            children: <Widget>[ 
              ProfilePic(userProfilePicUrl),
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sair'),
                onPressed: () async {
                  await _auth.signOut();
                }),
          ]),
        ),
      ),
    );
  }
}

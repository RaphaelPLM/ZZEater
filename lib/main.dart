import 'package:flutter/material.dart';
import 'package:zzeater/models/user.dart';
import 'package:zzeater/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:zzeater/views/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

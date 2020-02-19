import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zzeater/models/user.dart';
import 'package:zzeater/views/authenticate/authenticate.dart';
import 'package:zzeater/views/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

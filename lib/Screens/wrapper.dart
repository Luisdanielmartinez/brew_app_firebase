import 'package:brew_app/Models/user.dart';
import 'package:brew_app/Screens/Authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

import 'package:brew_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';
import 'Screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

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

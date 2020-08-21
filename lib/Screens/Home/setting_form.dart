import 'package:brew_app/Models/user.dart';
import 'package:brew_app/Services/database.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String currentName;
  String currentSugars;
  int currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'update your brew setting',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) =>
                        val.isEmpty ? "Please enter a name" : null,
                    onChanged: (val) {
                      setState(() {
                        currentName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: currentSugars ?? userData.sugars,
                    validator: (value) =>
                        currentSugars.isEmpty ? "please select a sugar" : null,
                    items: sugars.map((g) {
                      return DropdownMenuItem(
                        value: g,
                        child: Text('$g sugars'),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => currentSugars = value),
                  ),
                  //slider
                  Slider(
                    value: (currentStrength ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.brown[currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[currentStrength ?? userData.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (value) =>
                        setState(() => currentStrength = value.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        print(currentName);
                        await DatabaseService(uid: user.uid).updataUserData(
                            currentSugars ?? userData.sugars,
                            currentName ?? userData.name,
                            currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

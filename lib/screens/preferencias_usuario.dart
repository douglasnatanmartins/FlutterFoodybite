import 'package:flutter/material.dart';
import 'package:flutter_foodybite/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';

import 'main_screen.dart';

class PreferenceUser extends StatefulWidget {
  @override
  _PreferenceUserState createState() => _PreferenceUserState();
}

class _PreferenceUserState extends State<PreferenceUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Preferencias",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.rotate,
                      duration: Duration(seconds: 1),
                      child: MainScreen()))),
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: Positioned(
              child: ScopedModelDescendant<UserModel>(
                  builder: (context, child, model) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(" "),
                      ],
                    )
                  ],
                );
              }),
            )));
  }
}

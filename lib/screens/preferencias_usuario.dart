import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodybite/models/signInGoogle.dart';
import 'package:flutter_foodybite/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';

import 'homePageLogin.dart';
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
          elevation: 5,
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
          child: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
            return Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                ),
                children: <Widget>[
                  Text(
                    "Ola, ${!model.isLoggedIn() ? " " : model.userData["name"]}",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                  SizedBox(height: 22,),
                  Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        child: Text(
                          " Nome:    ${!model.isLoggedIn() ? " " : model.userData["name"]}",
                          style: TextStyle(
                              color: Colors.purple,
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ),
                        ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 200,
                    child: Text(
                      " Email:    ${!model.isLoggedIn() ? " " : model.userData["email"]}",
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      " Endereço:    ${!model.isLoggedIn() ? " " : model.userData["address"]}",
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),

                  FlatButton(
                     onPressed: (){
                       if (!model.isLoggedIn())
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => HomePageLogin()));
                       else
                         model.signOut();
                     },
                    color: Colors.purple,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.purple[700],),
                    ),
                    child: Text(
                      !model.isLoggedIn() ? "Entre ou Cadestre-se >" : "Sair",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}

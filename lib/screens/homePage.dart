import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_foodybite/screens/sigin_up_page.dart';
import 'package:flutter_foodybite/screens/signi_in_page.dart';
import 'package:flutter_foodybite/styles/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';




class HomePage extends StatefulWidget {
  final String pageTitle;


  HomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  _enssurreLoggedIn() async{
    GoogleSignInAccount user = _googleSignIn.currentUser;
    if(user == null){
      user = await  _googleSignIn.signInSilently();
      if( user == null){
        user = await  _googleSignIn.signIn();

        if(await _auth.currentUser() == null){
          GoogleSignInAuthentication credentials = await _googleSignIn.currentUser.authentication;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _fundoMenuInicio()=> Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Color.fromARGB(200, 244,164, 96), Color.fromARGB(255, 199, 21, 133) ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
    return Scaffold(
      body:Stack(
        children: <Widget>[
          _fundoMenuInicio(),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/login_logo.png"),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 0),
                    child: Text('Menu Fryo.!', style: TextStyle(fontSize:40, color: prefix0.Colors.white,
                    fontFamily: "Poppins"),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(bottom: 0),
                    child: FlatButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, PageTransition(
                            type: PageTransitionType.rotate, duration: Duration(seconds: 1),
                            child: SignInPage()));
                      },
                      child: Text("Entrar", style: TextStyle(
                          color: prefix0.Colors.white,
                          fontSize: 20,
                        fontFamily: "Poppins"
                      ),
                      ),
                      shape: StadiumBorder(),
                      color: primaryColor,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Text('Linguagem:', style: TextStyle(color: Color(0xFF000000))),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text('Porutguês ›', style: TextStyle(color: Color(0xFF108b04), fontWeight: FontWeight.w700)),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(0),
                    child:FlatButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, PageTransition(
                            type: PageTransitionType.downToUp, duration: Duration(seconds: 1),
                            child: SignUpPage()));
                      },
                      child: Text("Increver-se", style: TextStyle(
                          fontSize: 20,
                          color: prefix0.Colors.white
                      ),
                      ),
                      shape: StadiumBorder(),
                      color: primaryColor,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              )
          ),

        ],
      )

    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_foodybite/screens/home.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  final String pageTitle;

  HomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/welcome.png', width: 190, height: 190),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 0),
                child: Text('MenuX!', style: TextStyle(fontSize:10, color: Colors.green )),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.only(bottom: 0),
                child: FlatButton(
                  onPressed: (){

                  },
                    child: Text("Entrar", style: TextStyle(
                      color:Colors.white,
                      fontSize: 20
                    ),)
                  ,
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(0),
                child:FlatButton(
                  onPressed: (){

                  },
                  child: Text("Increver-se", style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),)
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Text('Linguagem:', style: TextStyle(color: Colors.black)),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      child: Text('Porutguês ›', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              )
            ],
          )),
      backgroundColor: Colors.black,
    );
  }
}

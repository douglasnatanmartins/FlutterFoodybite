import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foodybite/screens/homePage.dart';
import 'package:flutter_foodybite/screens/main_screen.dart';
import 'package:flutter_foodybite/util/const.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';


void main() async{
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: isDark?Brightness.light:Brightness.dark,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme:ThemeData(
    primarySwatch: Colors.purple,
        primaryColor: Colors.purple),
        home: HomePage(),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_foodybite/models/user_model.dart';
import 'package:flutter_foodybite/screens/home.dart';
import 'package:flutter_foodybite/screens/signi_in_page.dart';
import 'package:flutter_foodybite/styles/color.dart';
import 'package:flutter_foodybite/styles/style.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:page_transition/page_transition.dart';



class SignUpPage extends StatefulWidget {


  final String pageTitle;

  SignUpPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _adressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 10.0,
          backgroundColor: white,
          title: Text('Inscrever-se',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 20)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed('/signin');
                Navigator.pushReplacement(context, PageTransition(
                    type: PageTransitionType.rotate,
                    duration: Duration(seconds: 1),
                    child: SignInPage()
                ));
              },
              padding: EdgeInsets.all(3),
              child: Text('Entrar', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)),
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),),
                        hintText: "Nome Completo",
                        labelText: "Nome Completo",
                        focusColor: Colors.green,
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.green,
                        )),
                    validator: (text) {
                      if (text.isEmpty) return "Nome Invalido!";
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: "brucewayne@hotmail.com",
                        labelText: "e-mail",
                        icon: Icon(
                          Icons.email,
                          color: Colors.green,
                        )),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail Invalido!";
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Senha",
                        labelText: "Senha",
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.green,
                        )),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 5)
                        return "Senha Inválida";
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _adressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Endereço",
                        labelText: "Endereço",
                        helperText: " ",
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.green,
                        )),
                    validator: (text) {
                      if (text.isEmpty) return "Endereço Invalido!";
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _adressController.text
                          };

                          model.signUp(userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFaill,
                          );
                        }
                      },

                      color: primaryColor,
                      padding: EdgeInsets.all(13),
                      shape: StadiumBorder(),
                      child: Text("Criar Conta", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!"),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Home())
      );
    }
    );
  }


  void _onFaill() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );

  }

}


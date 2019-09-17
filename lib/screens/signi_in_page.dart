import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foodybite/models/user_model.dart';
import 'package:flutter_foodybite/screens/sigin_up_page.dart';
import 'package:flutter_foodybite/styles/color.dart';
import 'package:flutter_foodybite/styles/style.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:page_transition/page_transition.dart';
import 'home.dart';

class SignInPage extends StatefulWidget {
  final String pageTitle;

  SignInPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 10,
          backgroundColor: white,
          title: Text('Entrar',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 20)),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed('/signup');
                Navigator.pushReplacement(context, PageTransition(
                    type: PageTransitionType.rotate, duration: Duration(seconds: 1),
                    child: SignUpPage()));
              },
              child: Text('Inscrever-se', style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ), ),
            ),

          ],
        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading)
                return Center(child: CircularProgressIndicator(),);

              return Form(
                key: _formKey,
                child: Card(
                  elevation: 10,
                  child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: <Widget>[
                        Text("Bem - Vindo de Volta!",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "Poppins",
                            color: Colors.green,
                            fontWeight: FontWeight.bold

                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 13.0,),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              hintText: "bruce_wayne@hotmail.com",
                              labelText: "e-mail",
                              icon: Icon(Icons.email, color: Colors.green,)
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text.isEmpty || !text.contains("@"))
                              return "E-mail Invalido!";
                          },
                        ),
                        SizedBox(height: 13.0),
                        TextFormField(
                          controller: _passController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              hintText: "Senha",
                              labelText: "Senha",
                              helperText: " ",
                              icon: Icon(Icons.vpn_key, color: Colors.green,)
                          ),
                          obscureText: true,
                          validator: (text) {
                            if (text.isEmpty || text.length < 5)
                              return "Senha Inválida";
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              if(_emailController.text.isEmpty)
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text("insira email para recuperação"),
                                      backgroundColor: Colors.redAccent,
                                      duration: Duration(seconds: 2),
                                    )
                                );
                              else {
                                model.recoveryPass(_emailController.text);
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text("Confira seu Email"),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    )
                                );
                              }


                            },
                            padding: EdgeInsets.all(8),
                            color: Colors.grey,
                            shape: StadiumBorder(),
                            child: Text("Esqueci minha senha >",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 13
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {

                              }
                              model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFaill: _onFail,
                              );
                            },
                            color: Colors.green,
                            padding: EdgeInsets.all(13),
                            shape: StadiumBorder(),
                            child: Icon(
                                Icons.arrow_forward, size: 30),
                          ),
                        )
                      ]
                  ),
                ),
              );
            }

        )

    );


  }


  void _onSuccess() {
    Future.delayed(Duration(microseconds: 100)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Home())
      );
    },
    );

  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao Entrar"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}
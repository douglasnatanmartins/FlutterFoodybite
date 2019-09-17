import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';


class UserModel extends Model {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;


  //SignUp - Inscrever-se
  void signUp({@required Map<String, dynamic> userData, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}){

    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async {
      firebaseUser = user.user;

      await _saveUserData(userData);

      onFail();
      isLoading = false;
      notifyListeners();

    }).catchError((erro){
      print("falha: erro" + erro.toString());
      onSuccess();
      isLoading = false;
      notifyListeners();
    });

  }



  //SignIn - Entrar
  void signIn({@required String email, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFaill})async {

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(
        email: email,
        password: pass
    ).then((user)
    {
      firebaseUser = user.user;

      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      print("falla:erro" + e.toString());
      onFaill();
      isLoading = false;
      notifyListeners();
    });


  }


  // signOut -- Deslogar-se
  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }


  //recoveryPass --- Recuperação de senha
  void recoveryPass(String email) {
    _auth.sendPasswordResetEmail(email: email);

  }

  //LOGAR USUARIO
  bool isLoggedIn() {
    return firebaseUser != null;
  }



  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}

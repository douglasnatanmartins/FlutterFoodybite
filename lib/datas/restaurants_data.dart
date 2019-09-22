import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantsData {

  String id;

  String title;
  String adreess;

  bool rating;


  RestaurantsData.fromDocuments(DocumentSnapshot snapshot){

    id = snapshot.documentID;
    title = snapshot.data["title"];
    adreess = snapshot.data["adreess"];
  }
}
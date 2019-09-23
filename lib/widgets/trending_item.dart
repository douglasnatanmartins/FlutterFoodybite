import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodybite/util/const.dart';

class TrendingItem extends StatefulWidget {
  final String img;
  final String title;
  final String address;
  final String rating;




  TrendingItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.address,
    @required this.rating,
  }) : super(key: key);


  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {

  final FirebaseStorage storage = FirebaseStorage(
      app: Firestore.instance.app,
      storageBucket: 'gs://menu-sti.appspot.com' );
  Uint8List imageBytes;
  String erroMsg;

  _MyHomePageState(){
    storage.ref().child("adesivo-parede-prato-comida-frango-salada-restaurante-lindo-adesivo-parede.jpg").getData(10000000).then((data) =>
        setState((){
          imageBytes = data;
        })
    ).catchError((e) =>
        setState(() {
          erroMsg = e.error;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    /*var img = imageBytes != null ? Image.memory(
      imageBytes,
      fit: BoxFit.cover,
    ) : Text(erroMsg != null ? erroMsg : "Loading...");*/

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 3.0,
            child: Wrap(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width * 1.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          "${widget.img}",
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Positioned(
                      top: 3.0,
                      right: 6.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Constants.ratingBG,
                                size: 10,
                              ),
                              Text(
                                " ${widget.rating} ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 2.0,
                      child: Padding(
                          padding: EdgeInsets.all(1),
                            child: RaisedButton(
                              onPressed: () {

                              },
                              child: Text( "Abrir",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            color: Colors.white,
                              elevation: 3,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.0),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${widget.title}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${widget.address}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sozlistesi01/models/students.dart';

class TekListe extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TekListe> {
  FocusNode myFocusNode;
  String baslik = 'Tek Kayıt Liste';
  String baslik1 = "baslik1";
  String numberId = '123456';
  String numberText = "";
  int count = 0;
  String numberDeneme = '';

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
    number.clear();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    number.dispose();
    super.dispose();
  }

  TextEditingController number = TextEditingController();

  _dismissDialog() {
    Navigator.pop(context);
  }

  void hesapla() {
    setState(() {
      //sonuc = double.parse(firstName.text) /
      //  (double.parse(lastName.text) * double.parse(lastName.text));
      //print(sonuc);
    });
  }

  Future<QuerySnapshot> denemex() async {
    await FirebaseFirestore.instance
        .collection('studentData')
        .doc('hYiQDBqCYtn57en469Kt')
        .get()
        .then((DocumentSnapshot value) {
      if (value.exists) {
        print('kayit var');
      } else {
        print('kayit yok');
      }
    });
  }

  Future<QuerySnapshot> denemey() async {
    await FirebaseFirestore.instance
        .collection('studentData')
        .get()
        .then((QuerySnapshot value) {
      //print(value.docs.elementAt(1).id);
      numberId = value.docs.elementAt(1).id;
    });
  }

  Future<QuerySnapshot> denemeDelete(String idDeneme) async {
    await FirebaseFirestore.instance
        .collection('studentData')
        .doc(idDeneme)
        .delete();
  }

  Future<QuerySnapshot> denemeAdd(String numberAdd) async {
    FirebaseFirestore firebaseFirestore = await FirebaseFirestore.instance;
    CollectionReference denemeData =
    firebaseFirestore.collection('studentData');
    denemeData.add(
        {'firstName': 'izmir35', 'lastName': 'izmir935', 'number': numberAdd});
  }

  Future<void> fetch1() async {
    return await Future.delayed(Duration(seconds: 1), () {
      singleView1(numberDeneme);
    });
  }

  Future<QuerySnapshot> singleView(String recort) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference dataBase =
    await firebaseFirestore.collection('studentData');
    print(dataBase.doc(recort).id);
  }

  Future<DocumentSnapshot> singleView1(String recort) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference dataBase =
    await firebaseFirestore.collection('studentData');
    print(dataBase.doc(recort).id);
   await dataBase.doc(recort).get().then((value) {
     print(value.get('firstName')+value.get('lastName')+value.get('number'));
   });
  }

  Future<QuerySnapshot> denemeView(String kayitNumber) async {
    FirebaseFirestore.instance
        .collection('studentData')
        .where('number', isEqualTo: kayitNumber)
        .get()
        .then((value) {
      print(value.docs.length);
      if (value.docs.length == 1) {
        value.docs.forEach((element) {
          numberDeneme = element.id;
          //print(numberDeneme);
        });
      } else {
        numberDeneme = '0';
      }
    });
  }

  Future<void> fetch() async {
    return await Future.delayed(Duration(seconds: 3), () {
      print('fetch');
      print('numberId' + numberId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(baslik),
        ),
        body: Column(
          children: [
            Column(
              children: [
                TextField(
                  enabled: true,
                  autofocus: false,
                  // style: TextStyle(height: 3.0, fontWeight: FontWeight.bold,fontSize: 30.0),
                  style: TextStyle(fontSize: 20.0),
                  //cursorWidth: 5.0,
                  //focusNode: myFocusNode,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Number",
                    labelStyle: TextStyle(fontSize: 20.0),
                  ),
                  controller: number,
                  /*onChanged: (String value1) {
                    numberText = value1;
                  },*/
                  //keyboardType: TextInputType.number,
                  //textInputAction: TextInputAction.done,
                  //readOnly: true,
                  //obscureText: true,
                ),
                ElevatedButton(
                    child: Text('Silme işlemi yapıldı.',
                        style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      setState(() {
                        print('Silme şlemi yapıldı');
                        number.clear();
                        showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            title: Text("Text Dialog"),
                            content: Text("Hey I'm Coflutter"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    _dismissDialog();
                                  },
                                  child: Text('Close')),
                              TextButton(
                                onPressed: () {
                                  print('HelloWorld!');
                                  _dismissDialog();
                                },
                                child: Text('HelloWorld!'),
                              )
                            ],
                          ),
                        );
                      });
                    }),
                ElevatedButton(
                  onPressed: () async {
                    //Navigator.pop(context);
                     await denemeView(number.text);
                     await fetch1();
                    // await denemeDelete(numberDeneme);
                    print('Tek kayit listeleme islemi yapildi');
                  },
                  child: Text(
                    "Bu sayfayı kapat",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

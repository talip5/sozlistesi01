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
  String numberId = '3535';
  String numberText = "";
  int count = 0;
  String numberDeneme = '';
  String firstname1 = '';
  String lastName1 = '';
  String number1 = '';
  String firstnamex = '';
  String lastNamex = '';
  String numberx = '';

  @override
  void initState() {
    super.initState();
    //number.text = numberId;
    //yaz(number.text);
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
   // myFocusNode.dispose();
    number.dispose();
    super.dispose();
  }

  TextEditingController number = TextEditingController();

  _dismissDialog() {
    Navigator.pop(context);
  }

  void yaz(String yaz1) {
    print(yaz1);
  }

  Future<void> fetch1() async {
    return await Future.delayed(Duration(seconds: 1), () {
      if (numberDeneme != '0') {
        singleView1(numberDeneme);
      }
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
      firstname1 = value.get('firstName');
      lastName1=value.get('lastName');
      number1=value.get('number');
      print(value.get('firstName') + value.get('lastName') + value.get('number'));
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
    return await Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        if (numberDeneme != '0') {
          firstname1;
          lastName1;
          number1;
          firstnamex = 'FirstName : ';
          lastNamex = 'LastName : ';
          numberx = 'Number  : ';
        }
        else{
          firstname1='KAYIT YOK.';
          lastName1='';
          number1='';
          firstnamex = '';
          lastNamex = '';
          numberx = '';
        }
      });
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
                SizedBox(height: 20,),
                Container(
                  height: 30,
                    width: 250,
                    child: Text(firstnamex+'   '+firstname1,style: TextStyle(fontSize: 20.0),)),
                Container(
                    height: 30,
                    width: 250,
                    child: Text(lastNamex+'   '+lastName1,style: TextStyle(fontSize: 20.0),)),
                Container(
                    height: 30,
                    width: 250,
                    child: Text(numberx+'   '+number1,style: TextStyle(fontSize: 20.0),)),
                SizedBox(height: 60.0),
                Container(
                  width: 250,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () async {
                      denemeView(number.text);
                      await fetch1();
                      // await denemeDelete(numberDeneme);
                      print('Tek kayit listeleme islemi yapildi');
                      setState(() {
                        fetch();
                        /*showDialog(
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
                        );*/
                      });
                    },
                    child: Text(
                      "Tek Kayit Listeleme",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 250,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      print('Ana sayfaya donuldu');
                    },
                    child: Text(
                      "Bu sayfayı kapat",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                /*SizedBox(height: 10.0),
                Container(
                  width: 250,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      print('Deneme');
                     showDialog(
                       barrierColor: Colors.green,
                       barrierDismissible: false,
                         context: context,
                         builder: (BuildContext context){
                           return AlertDialog(
                             content: Text('ust yazi'),
                             backgroundColor: Colors.deepOrangeAccent,
                             title: Text('material Alert'),
                             actions: [
                              TextButton(
                               onPressed: (){
                                 _dismissDialog();
                           },
                               child: Text('Close',style: TextStyle(fontSize: 25.0,backgroundColor: Colors.white,color: Colors.black),)),
                             ],
                           );
                         }
                     );
                    },
                    child: Text(
                      "Deneme",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

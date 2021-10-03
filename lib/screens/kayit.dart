import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sozlistesi01/models/students.dart';

class Kayit extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Kayit> {
  FocusNode myFocusNode;
  String firstName1='';
  String lastName1='';
  String number1='';

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    //firstName.addListener(printLatestValue);
    //firstName.addListener(printLatestValue);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    firstName.dispose();
    lastName.dispose();
    number.dispose();
    //firstName.dispose();
    super.dispose();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();

  _dismissDialog() {
    Navigator.pop(context);
  }

  Future<void> fetch1() async {
    return await Future.delayed(Duration(seconds: 1), () {
      firstName.text='';
      lastName.text='';
      number.text='';
    });
  }

  void printLatestValue(){
    print('Second textfield : ${
    firstName.text
    }');
  }

  void hesapla() {
    setState(() {
      //sonuc = double.parse(firstName.text) /
      //  (double.parse(lastName.text) * double.parse(lastName.text));
      //print(sonuc);
    });
  }

  Future<void> addTextData() async {
    firstName1=firstName.text;
    lastName1=lastName.text;
    number1=number.text;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference database =
    await firebaseFirestore.collection('studentData');
    database.add({
      'firstName': firstName1,
      'lastName': lastName1,
      'number': number1
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kayıt Girişi'),
        ),
        body: Column(
          children: [
            Column(
              children: [
                TextField(
                  enabled: true,
                  autofocus: true,
                  focusNode: myFocusNode,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "firstName",
                    labelStyle: TextStyle(fontSize: 20.0),
                  ),
                  controller: firstName,
                  style: TextStyle(fontSize: 20.0),
                  //keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  /*onChanged: (text){
                    print('firstName giriş yapıldı : ${text}');
                  },*/
                ),
                TextField(
                  enabled: true,
                  //autofocus: true,
                  // style: TextStyle(height: 3.0, fontWeight: FontWeight.bold,fontSize: 30.0),
                  style: TextStyle(fontSize: 20.0),
                  //cursorWidth: 5.0,
                  //focusNode: myFocusNode,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "lastName",
                    labelStyle: TextStyle(fontSize: 20.0),
                  ),
                  controller: lastName,
                  //keyboardType: TextInputType.number,
                  //textInputAction: TextInputAction.done,
                  //readOnly: true,
                  //obscureText: true,
                ),
                TextField(
                  //enabled: true,
                  //autofocus: false,
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
                  //keyboardType: TextInputType.number,
                  //textInputAction: TextInputAction.done,
                  //readOnly: true,
                  //obscureText: true,
                ),
                ElevatedButton(
                    child:
                    Text('Kayıt Girişi', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      setState(() {
                        addTextData();
                        print('Kayıt yapıldı');
                        fetch1();
                        //myFocusNode.previousFocus();
                        myFocusNode.requestFocus();
                      });
                    }),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //print(list.first.firstName1+list.first.lastName1+list.first.number1.toString());
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

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

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    //myFocusNode.dispose();
    firstName.dispose();
    lastName.dispose();
    number.dispose();
    super.dispose();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
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

  Future<void> addTextData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference database = await firebaseFirestore.collection(
        'studentData');
    database.add({
      'firstName': firstName.text,
      'lastName': lastName.text,
      'number': number.text
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
          Column(children: [
          TextField(
          enabled: true,
            autofocus: true,
            focusNode: myFocusNode,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: "firstName", labelStyle: TextStyle(fontSize: 20.0),
            ),
            controller: firstName,
            style: TextStyle(fontSize: 20.0),
            //keyboardType: TextInputType.number,
            textInputAction: TextInputAction.none,
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
              labelText: "lastName", labelStyle: TextStyle(fontSize: 20.0),),
            controller: lastName,
            //keyboardType: TextInputType.number,
            //textInputAction: TextInputAction.done,
            //readOnly: true,
            //obscureText: true,
          ),

          TextField(
            enabled: true,
            autofocus: false,
            // style: TextStyle(height: 3.0, fontWeight: FontWeight.bold,fontSize: 30.0),
            style: TextStyle(fontSize: 20.0),
            //cursorWidth: 5.0,
            //focusNode: myFocusNode,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: "Number", labelStyle: TextStyle(fontSize: 20.0),),
            controller: number,
            //keyboardType: TextInputType.number,
            //textInputAction: TextInputAction.done,
            //readOnly: true,
            //obscureText: true,
          ),

          ElevatedButton(
              child: Text('Kayıt Girişi', style: TextStyle(fontSize: 20.0)),
              onPressed: () {
                setState(() {
                  addTextData();
                  print('Kayıt yapıldı');
                  firstName.clear();
                  lastName.clear();
                  number.clear();
                  showDialog(
                    context: context,
                    builder: (_) =>
                    new AlertDialog(title: Text("Text Dialog"),
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
                  onPressed: (){
                    Navigator.pop(context);
                    //print(list.first.firstName1+list.first.lastName1+list.first.number1.toString());
                  },
                  child: Text("Bu sayfayı kapat",style: TextStyle(fontSize: 20.0),),
                ),
    ],
    ),
    ],
    ),
    ),
    );
  }
}

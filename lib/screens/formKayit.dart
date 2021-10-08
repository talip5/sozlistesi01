import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sozlistesi01/models/students.dart';

class FormKayit extends StatefulWidget {

Students students=Students('','',0);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FormKayit> {
  var formKey=GlobalKey<FormState>();
  String firstName5='';
  String lastName5='';
  int number5=0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  Future<void> addTextData() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference database =
    await firebaseFirestore.collection('studentData');
    database.add({
      'firstName': firstName5,
      'lastName': lastName5,
      'number': number5
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form Kayıt Girişi'),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ogrenci Adi ',
                  hintText: 'Engin'
                ),
                onSaved: ( String value){
                  print(value);
                widget.students.firstNames=value;
                firstName5=widget.students.firstNames;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Ogrenci Soyadi ',
                    hintText: 'Demirog'
                ),
                onSaved: ( String value){
                  print(value);
                  widget.students.lastNames=value;
                  lastName5=widget.students.lastNames;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Aldigi not ',
                    hintText: '76'
                ),
                onSaved: ( String value){
                  print(value);
                  widget.students.numbers=int.parse(value);
                  number5=widget.students.numbers;
                },
              ),
              SizedBox(height: 40.0,),
              ElevatedButton(
                  child:Text('Form Kayıt Girişi', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    formKey.currentState.save();
                    addTextData();
                  }
                  ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Bu sayfayı kapat",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ]
          ),
        ),
        ),
      );
  }
}

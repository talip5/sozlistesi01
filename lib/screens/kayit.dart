import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class Kayit extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Kayit> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    //myFocusNode.dispose();
    super.dispose();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName= TextEditingController();
  double sonuc = 0;

  _dismissDialog() {
    Navigator.pop(context);
  }


  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('data').get();
    return querySnapshot;
  }

  Future<void> addData() async{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    CollectionReference database=await firebaseFirestore.collection('data');
    //DocumentReference documentReference=database.doc('4');
    //documentReference.set({'name':'kemal'});
    database.add({'name':'izmir75'});

  }

  void hesapla() {
    setState(() {
      sonuc = double.parse(firstName.text) /
          (double.parse(lastName.text) * double.parse(lastName.text));
      print(sonuc);
    });
  }
  Future<void> addTextData() async{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    CollectionReference database=await firebaseFirestore.collection('data');
    //DocumentReference documentReference=database.doc('4');
    //documentReference.set({'name':'kemal'});
    database.add({'name':firstName.text});
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
            FutureBuilder(
                future: getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //just add this line
                  if(snapshot.data == null) return CircularProgressIndicator();
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                          return ListTile(
                            title: Text(
                              documentSnapshot.get('name'),
                            ),
                            onTap: (){
                              print('silme');
                              setState(() {

                              });
                            },
                          );
                        }),
                  );
                }),
            Column(
              children: [
                TextField(
                  enabled: true,
                  autofocus: true,
                  focusNode: myFocusNode,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "firstName",labelStyle: TextStyle(fontSize: 25.0),
                  ),
                  controller: firstName,
                  style: TextStyle(fontSize: 30.0),
                  //keyboardType: TextInputType.number,
                ),
                TextField(
                  enabled: true,
                  autofocus: false,
                 // style: TextStyle(height: 3.0, fontWeight: FontWeight.bold,fontSize: 30.0),
                  style: TextStyle(fontSize: 30.0),
                  cursorWidth: 5.0,
                  //focusNode: myFocusNode,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "lastName",labelStyle: TextStyle(fontSize: 25.0),),
                    controller: lastName,
                  //keyboardType: TextInputType.number,
                  //readOnly: true,
                  //obscureText: true,
                ),

                ElevatedButton(
                    child: Text('Kayıt Girişi',style: TextStyle(fontSize: 30.0)),
                    onPressed: (){
                      setState(() {
                        //addData();
                        //hesapla();
                        addTextData();
                        showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(title: Text("Text Dialog"),
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
                  },
                  child: Text("Bu sayfayı kapat",style: TextStyle(fontSize: 30.0),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class Liste extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Liste> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('studentData').get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liste'),
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
                              print(documentSnapshot.get('name'));
                              String name1=documentSnapshot.get('name');
                              String result1=name1.trim();
                              String giris='Yalova95                       ';
                              String girisTrim=giris.trim();
                              if(result1==girisTrim){
                                //yazi();
                                print('Tamam 3500');
                              }
                            },
                          );
                        }),
                  );
                }),
            Column(
              children: [
                /*SizedBox(
                  height: 100,
                ),*/
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

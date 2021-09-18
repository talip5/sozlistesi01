import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class Silme extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Silme> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('data').get();
    return querySnapshot;
  }

  Future<void> deleteData(String kayitNo) async{
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    CollectionReference database=await firebaseFirestore.collection('data');
    database.doc(kayitNo).delete();
     }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Silme'),
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
                                deleteData(documentSnapshot.id);
                              });
                              },
                          );
                        }),
                  );
                }),
            Expanded(
              child:Column(
                children: [
                  /*SizedBox(
                    height: 100,
                  ),*/
                  ElevatedButton(
                      child: Text('Silme',style: TextStyle(fontSize: 30.0)),
                    onPressed: (){
                      print('silme35');
                      setState(() {
                        deleteData('5');
                      });
                    }),
                  ElevatedButton(
                    onPressed: (){
                      print('silme deneme');
                      Navigator.pop(context);
                    },
                    child: Text("Bu sayfayı kapat",style: TextStyle(fontSize: 30.0),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

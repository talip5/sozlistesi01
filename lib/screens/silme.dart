import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Silme extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Silme> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('studentData').get();
    return querySnapshot;
  }

  Future<void> deleteData(String kayitNo) async{
    CollectionReference database=await firebaseFirestore.collection('studentData');
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
                              documentSnapshot.get('firstName'),
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
                   ElevatedButton(
                      child: Text('Silme',style: TextStyle(fontSize: 30.0)),
                    onPressed: (){
                      setState(() {
                        //deleteData('5');
                      });
                    }),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Bu sayfay?? kapat",style: TextStyle(fontSize: 30.0),),
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

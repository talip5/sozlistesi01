import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  yazi(){
    print('yazi');
    String string1='    ali';
    print(string1);
    String result=string1.trim();
    print(result);
  }

  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('data').get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Future'),
        ),
        body: FutureBuilder(
            future: getData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //just add this line
                  if(snapshot.data == null) return CircularProgressIndicator();
              return ListView.builder(
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
                        String giris='Yalova9511                        ';
                        String girisTrim=giris.trim();
                        if(result1==girisTrim){
                          //yazi();
                          print('Tamam 3500');
                        }
                      },
                    );
                  });
            }),
      ),
    );
  }
}

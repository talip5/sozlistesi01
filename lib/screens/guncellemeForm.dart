import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class GuncellemeForm extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<GuncellemeForm> {

  String kayitNo="";
  TextEditingController firstName= TextEditingController();
  TextEditingController lastName= TextEditingController();
  TextEditingController number = TextEditingController();


  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('studentData').get();
    return querySnapshot;
  }

  Future<void> updateData(String kayitNo) async{
    CollectionReference database=await firebaseFirestore.collection('studentData');
    database.doc(kayitNo).update({'firstName':firstName.text,'lastName':lastName.text,'number':number.text});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GüncellemeForm'),
        ),
        body: Column(
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
                labelText: "FirstName",
                labelStyle: TextStyle(fontSize: 20.0),
              ),
              controller: firstName,
            ),
            TextField(
              enabled: true,
              autofocus: false,
              //style: TextStyle(height: 3.0, fontWeight: FontWeight.bold,fontSize: 20.0),
              style: TextStyle(fontSize: 20.0),
              //cursorWidth: 5.0,
              //focusNode: myFocusNode,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "LastName",
                labelStyle: TextStyle(fontSize: 20.0),
              ),
              controller: lastName,
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
                labelText: "Number",
                labelStyle: TextStyle(fontSize: 20.0),
              ),
              controller: number,
            ),
            Text('TextField',style: TextStyle(fontSize: 20.0),),
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
                              documentSnapshot.get('firstName')+'     '+documentSnapshot.get('lastName')+'     '+documentSnapshot.get('number'),
                            ),
                            onTap: (){
                              print('Güncelleme');
                              setState(() {
                                String firstNamex=documentSnapshot.get('firstName');
                                String lastNamex=documentSnapshot.get('lastName');
                                String numberx=documentSnapshot.get('number');
                                firstName.text=firstNamex;
                                lastName.text=lastNamex;
                                number.text=numberx;
                                print(number.text);
                                kayitNo=documentSnapshot.id;
                                print(kayitNo);
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
                      child: Text('Güncelleme',style: TextStyle(fontSize: 30.0)),
                      onPressed: (){
                        setState(() {
                          //updateData(kayitNo);
                          print('yönlendi');
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
            ),
          ],
        ),
      ),
    );
  }
}

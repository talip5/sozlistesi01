import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:sozlistesi01/models/students.dart';
import 'package:sozlistesi01/models/students1.dart';

import 'package:sozlistesi01/screens/guncellemeForm.dart';
import 'package:sozlistesi01/screens/student_add.dart';

class Guncelleme extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Guncelleme> {

List<Students> students=[
  Students('Ali1', 'Demir1',95),
  Students('Ali2', 'Demir2',45),
  Students('Ali3', 'Demir3',25)
];

  Students selectedStudents=Students('x1','x2',0);
  Students1 selectedStudents1=Students1('T1','T2','T3');

  String kayitNo="";
  String form='studentForm';

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getData() async {
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('studentData').get();
    return querySnapshot;
  }

  Future<void> updateData(String kayitNo) async{
    CollectionReference database=await firebaseFirestore.collection('studentData');
    database.doc(kayitNo).update({'firstName':'xxxxx'});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Güncelleme'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:students.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    title: Text(students[index].firstNames+'   '+students[index].lastNames),
                    subtitle: Text('Aldigi not :'+students[index].numbers.toString()+'   '+'['+students[index].getStatus+']'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://i2.wp.com/www.baubeclab.org/wp-content/uploads/2015/07/DSC_3193-e1437506729824.jpg?fit=639%2C639"),
                    ),
                    trailing: buildStatusIcon(students[index].numbers),
                    onTap: (){
                      setState(() {
                        this.selectedStudents=students[index];
                      });
                      print(selectedStudents.firstNames);
                    },
                  );
                }
              ),
            ),
            Text('Secili ogrenci '+selectedStudents.firstNames,style: TextStyle(fontSize: 20.0),),
            /*FutureBuilder(
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
                              setState(() {
                            // students.firstName=documentSnapshot.get('firstName');
                                this.selectedStudents1.firstName=documentSnapshot.get('firstName');
                                this.selectedStudents1.lastName=documentSnapshot.get('lastName');
                                this.selectedStudents1.number=documentSnapshot.get('number');
                              print('Güncelleme');
                                kayitNo=documentSnapshot.id;
                                print(kayitNo);
                               // updateData(kayitNo);
                              });
                            },
                          );
                        }),
                  );
                }),*/
            Text('Secili ogrenci '+selectedStudents1.firstName+'    '+selectedStudents1.lastName+'    '+selectedStudents1.number,style: TextStyle(fontSize: 20.0),),
            Expanded(
              child:Column(
                children: [
                  ElevatedButton(
                      child: Text('Güncelleme',style: TextStyle(fontSize: 20.0)),
                      onPressed: (){
                        setState(() {
                         print(students.length);
                          //updateData(kayitNo);
                          //Navigator.push(context,MaterialPageRoute(builder:(context)=>GuncellemeForm()));
                          print('güncelleme');
                        });
                      }),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Bu sayfayı kapat",style: TextStyle(fontSize: 20.0),),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: (){
                        print('Yeni ogrenci');
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAdd(students)));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5.0,),
                          Text('Yeni Ogrenci'),
                        ],
                      ),
                    ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: (){
                      print('Guncelle');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 5.0,),
                        Text('Guncelle'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent
                    ),
                    onPressed: (){
                      print('Sil');
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 5.0,),
                        Text('Sil'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusIcon(int grade){
    if(grade>=50){
      return Icon(Icons.done);
    }else if(grade>=40){
      return Icon(Icons.album);
    }else{
      return Icon(Icons.clear);
    }
  }
}

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
  @override
  void initState() {
    super.initState();
   setState(() {
     print(students.length);
   });
  }

List<Students> students=[
  Students('Ali1', 'Demir1',95),
  Students('Ali2', 'Demir2',45),
  Students('Ali3', 'Demir3',25)
];

  Students selectedStudents=Students('T1','T2',35);

  String kayitNo="";
  String form='studentForm';

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
            Text('Secili ogrenci '+selectedStudents.firstNames+'    '+selectedStudents.lastNames+'    '+selectedStudents.numbers.toString(),style: TextStyle(fontSize: 20.0),),
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
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAdd(students))).then((value) => setState((){}));
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAdd(students))).then((value) => {setState(() {})});
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

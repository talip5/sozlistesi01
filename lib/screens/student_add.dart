import 'package:flutter/material.dart';
import 'package:sozlistesi01/models/students.dart';
import 'package:sozlistesi01/models/students1.dart';

class StudentAdd extends StatefulWidget{

  List<Students> students;

  StudentAdd(List<Students> students){
    this.students=students;
  }
  //StudentAdd(this.students);

  @override
  State<StatefulWidget> createState() {
  return _StudentAddState();
  }
  
}

class _StudentAddState extends State<StudentAdd>{

  var formkey=GlobalKey<FormState>();
  var studentsQ=Students('','',35);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Ogrenci'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child:Form(
          key: formkey,
          child: Column(
            children: [
              TextButton(
                  onPressed: (){
                    print('islem yapildi');
                    print(studentsQ.numbers);
                  },
                  child:Text('Deneme')
              ),
              buildFirstNameField(),
              buildLastNameField(),
              buildNumberField(),
              buildSubmitButton(),
            ],
          ),
        ) ,
      ),
      );
  }
  Widget buildFirstNameField() {
   return TextFormField(
      decoration: InputDecoration(labelText: 'Ogrenci adi',hintText: 'Engin'),
      onSaved: (String value){
        studentsQ.firstNames=value;
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Ogrenci soyadi',hintText: 'Demirog'),
      onSaved: (String value){
        studentsQ.lastNames=value;
      },
    );
  }
  Widget buildNumberField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Aldigi not',hintText: '65'),
      onSaved: (String value){
        studentsQ.numbers=int.parse(value);
      },
    );
  }
  Widget buildSubmitButton(){
    return ElevatedButton(
        onPressed: (){
        formkey.currentState.save();
        widget.students.add(studentsQ);
        Navigator.pop(context);
        },
        child: Text('Kaydet'));
  }

}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int record = 0;
  String title1 = 'Future';

  var checkedValue = true;

  var newValue;

  Future<void> getData() async {
    Future<QuerySnapshot> querySnapshot =
    FirebaseFirestore.instance.collection('data').get();
    await querySnapshot.then((value) {
      record = value.docs.length;
      setState(() {
        title1 = record.toString();
      });
    });
  }

  Future<void> deleteData() async {
    await FirebaseFirestore.instance.collection('data').doc('2').delete();
  }

  Future<void> addData() async {
    await FirebaseFirestore.instance
        .collection('data')
        .doc('6')
        .set({'titlex': 'ali', 'isCheckx': 'true'});
  }

  Future<void> updateData() async {
    await FirebaseFirestore.instance
        .collection('data')
        .doc('6')
        .update({'isCheckx': 'false'});
  }

  Future<String> getFutureData() async {
    await Future.delayed(Duration(seconds: 1), () {
      return Future.value("12345");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title1),
        ),
        body: FutureBuilder(
            future: getFutureData(),
            initialData: 'waiting',
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if( snapshot.connectionState == ConnectionState.done){
                return Center(child: new Text('$snapshot.data'));
              }
              if( snapshot.connectionState == ConnectionState.waiting){
                return  Center(child: Text('Please wait its loading...'));
              }else{
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else
                  return Center(child: new Text('$snapshot.data'));  // snapshot.data  :- get your object which is pass from your downloadData() function
              }
            }
        )
    );
  }
}

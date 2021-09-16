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
  int _counter = 0;
  int record = 0;
  String title1 = 'Future';
  FirebaseFirestore db = FirebaseFirestore.instance;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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

  Future<void> updateData() async{
    await FirebaseFirestore.instance
        .collection('data')
        .doc('6')
        .update({'isCheckx':'false'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addData();
          print('data silindi');
          _incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

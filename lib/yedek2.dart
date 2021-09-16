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
        home: Scaffold(
            appBar: AppBar(
              title: Text('Future'),
            ),
            body: FutureBuilder(
              future: getFutureData(),
              builder: (ctx, snapshot) {
                // Checking if future is resolved or not
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occured',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object
                    final data = snapshot.data;
                    final data1=data*5;
                    return Center(
                      child: Text(
                        '$data1',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )));
  }
}

Future<int> getFutureData() {
  print('stream');
  return Future.delayed(Duration(seconds: 5), () {
    print('future');
    //return Future.value('xxxx353');
    return Future.value(35);
  });
}

Future<String> getData() {
  return Future.delayed(Duration(seconds: 2), () {
    return "I am data";
    // throw Exception("Custom Error");
  });
}

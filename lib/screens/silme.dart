import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Silme extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
          title: Text("Silme")),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Silme Sayfası",style: TextStyle(fontSize: 30.0),),
            ElevatedButton(
              child: Text("Bu sayfayı kapat"),
             // color: Colors.greenAccent,
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    )
    );
  }
}
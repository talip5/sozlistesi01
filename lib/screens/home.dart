import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.redAccent,
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text("Kayıt Sayfasına git",style: TextStyle(fontSize: 25.0),),
                //color: Colors.amber,
                onPressed: (){
                  Navigator.pushNamed(context, "/kayit");
                },
              ),
              ElevatedButton(
                child: Text("Liste Sayfasına git",style: TextStyle(fontSize: 25.0),),
                //color: Colors.amber,
                onPressed: (){
                  Navigator.pushNamed(context, "/liste");
                },
              ),
              ElevatedButton(
                child: Text("Silme Sayfasına git",style: TextStyle(fontSize: 25.0),),
                //color: Colors.amber,
                onPressed: (){
                  Navigator.pushNamed(context, "/silme");
                },
              ),
            ],
          ),
        )));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.redAccent,
          title: Text("Home35"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text("Tek Liste Sayfasına Git",style: TextStyle(fontSize: 25.0),),
                //color: Colors.amber,
                onPressed: (){
                  Navigator.pushNamed(context, "/tekListe");
                },
              ),
              ElevatedButton(
                child: Text("Silme Sayfasına git",style: TextStyle(fontSize: 25.0),),
                //color: Colors.amber,
                onPressed: (){
                  Navigator.pushNamed(context, "/silme");
                },
              ),
              ElevatedButton(
                child: Text("Tek Silme Sayfasına Git",style: TextStyle(fontSize: 25.0),),
                //color: Colors.amber,
                onPressed: (){
                  Navigator.pushNamed(context, "/tekSilme");
                },
              ),
            ],
          ),
        )));
  }
}

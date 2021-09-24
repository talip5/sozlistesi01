import 'package:flutter/material.dart';
import 'package:sozlistesi01/screens/home.dart';
import 'package:sozlistesi01/screens/kayit.dart';
import 'package:sozlistesi01/screens/liste.dart';
import 'package:sozlistesi01/screens/silme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sozlistesi01/screens/tekListe.dart';
import 'package:sozlistesi01/screens/tekSilme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.green,
    ),
    initialRoute: "/tekListe",
    routes: {
      "/":(context)=>Home(),
      "/liste":(context)=>Liste(),
      "/silme":(context)=>Silme(),
      "/kayit":(context)=>Kayit(),
      "/tekSilme":(context)=>TekSilme(),
      "/tekListe":(context)=>TekListe(),
    },
  ));
}
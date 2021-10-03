import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Students {

  String firstNames;
  String lastNames;
  int numbers;
  String status;
  String numbery;

  Students(String firstName1,String lastName1,int number1) {
    this.firstNames = firstName1;
    this.lastNames = lastName1;
    this.numbers = number1;
  }

  String get getStatus{
    String message='';
    if(this.numbers>=50){
      message='Gecti';
    }else if(this.numbers>40){
      message='Butunlemeye kaldi';
    }else{
      message='Kaldi';
    }
    this.status=message;
    return this.status;
  }

}
import  'package:flutter/material.dart';

class AppWidget{

  static TextStyle boldTextFieldStyle(){
    return TextStyle(
                color: Colors.black, 
                fontSize: 20.0, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }

  static TextStyle headlineTextFieldStyle(){
    return TextStyle(
                color: Colors.black, 
                fontSize: 24.0, 
                fontWeight: FontWeight.bold, 
                fontFamily: 'Poppins');
  }

  static TextStyle lightTextFieldStyle(){
    return TextStyle(
                color: Colors.black, 
                fontSize: 15.0, 
                fontWeight: FontWeight.w500, 
                fontFamily: 'Poppins');
  }
}
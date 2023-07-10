import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSnackBar {
  void show(context,message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
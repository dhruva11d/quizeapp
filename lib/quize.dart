import'package:flutter/material.dart';

void main(){
  runApp(QuizeApp());
}
class QuizeApp extends StatefulWidget {
  const QuizeApp({super.key});

  @override
  State<QuizeApp> createState() => _QuizeAppState();
}

class _QuizeAppState extends State<QuizeApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quize"),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple, Colors.pinkAccent],)
        ),
        child: Text("heloo"),
      ),


    );


  }
}

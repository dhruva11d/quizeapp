import 'package:flutter/material.dart';
class answer extends StatelessWidget {
  const answer({super.key, required this.ansText,required this.onTap});
  final String ansText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
          backgroundColor: Colors.blueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),

      onPressed: (){

    },child: Text(ansText),);
  }
}

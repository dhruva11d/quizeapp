import 'package:flutter/material.dart';
import 'home.dart';
import 'package:quizeapp/questions.dart';

class GradientContainer extends StatefulWidget {
  const GradientContainer({Key? key});

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App", style: TextStyle(color: Color(0xFFf2f2f2))),
        backgroundColor: Color(0xFF121212),
        elevation: 8,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pinkAccent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1, // Occupy the first half of the screen
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset('images/quiz-logo.png', width: 300, height: 300),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1, // Occupy the second half of the screen
              child: SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2, color: Colors.blueGrey),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.purpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        "Begin",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => QuizeApp()),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

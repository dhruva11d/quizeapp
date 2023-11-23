import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Qanswers/Qansers.dart';

void main() {
  runApp(QuizeApp());
}

class QuizeApp extends StatefulWidget {
  const QuizeApp({Key? key});

  @override
  State<QuizeApp> createState() => _QuizeAppState();
}

class _QuizeAppState extends State<QuizeApp> {
  int currentQuestionIndex = 0; // Start with the first question
  bool isCorrectAnswerSelected = false;
  bool isIncorrectAnswerSelected = false;
  final List<String> selectedAnswers = [];
  bool quizFinished = false;

  void chooseAnswer(String answer) {
    // Add the selected answer to the list
    selectedAnswers.add(answer);
  }

  void answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        // If the correct answer is selected
        isCorrectAnswerSelected = true;
        isIncorrectAnswerSelected = false;
      } else {
        // If an incorrect answer is selected
        isCorrectAnswerSelected = false;
        isIncorrectAnswerSelected = true;
      }
    });

    // Delay navigation to the next question for better user experience
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // Move to the next question if there is one
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
        } else {
          // Quiz finished, set the flag to navigate directly to the result screen
          quizFinished = true;
        }

        // Reset the flags for correct and incorrect answers
        isCorrectAnswerSelected = false;
        isIncorrectAnswerSelected = false;
      });

      // If all questions are answered, navigate to the result screen
      if (quizFinished) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ResultScreen(selectedAnswers: selectedAnswers),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz"),backgroundColor:Color(0xFF121212),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple, Colors.pinkAccent]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.2),
                      spreadRadius: 9,
                      blurRadius: 9,
                      offset: Offset(16, 7),
                    ),
                  ],
                ),
                child: Text(
                  currentQuestion.text,
                  style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'San Francisco'),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              ...currentQuestion.getShuffledAnswers().map((ans) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF96999),
                    fixedSize: Size(50, 50),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  ),
                  onPressed: () {
                    // Check if the selected answer is correct
                    bool isCorrect = currentQuestion.isCorrectAnswer(ans);

                    // Handle the selected answer
                    answerQuestion(isCorrect);
                    chooseAnswer(ans);
                  },
                  child: Text(
                    ans,
                    style: TextStyle(fontSize: 17, fontFamily: "San Francisco"),
                  ),
                );
              }),
              if (isCorrectAnswerSelected)
                AnimatedOpacity(
                  opacity: isCorrectAnswerSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Correct!',
                    style: GoogleFonts.agdasima(textStyle: TextStyle(color: Colors.green,fontSize: 20,
                        fontWeight: FontWeight.bold)),

                    textAlign: TextAlign.center,
                  ),
                ),
              if (isIncorrectAnswerSelected)
                AnimatedOpacity(
                  opacity: isIncorrectAnswerSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Oops you are wrong...',
                    style: GoogleFonts.agdasima(textStyle: TextStyle(color: Color(0xFF810505),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,)),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final List<String> selectedAnswers;

  ResultScreen({required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    // Calculate the score based on the selected answers
    int score = selectedAnswers.where((answer) {
      int questionIndex = selectedAnswers.indexOf(answer);
      return questions[questionIndex].isCorrectAnswer(answer);
    }).length;


    return Scaffold(
      appBar: AppBar(title: Text("Quiz Results"),backgroundColor:Color(0xFF121212)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple, Colors.pinkAccent]),
        ),
        child: Center(
          child: Container(
            height: 400,
            width: 300,
            child: Card(
              color: Color(0xFFf2f2f2), // Set card color to white
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Set border radius for a square shape
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your Answers:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // Display the selected answers in a card
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedAnswers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Question ${index + 1}: ${selectedAnswers[index]}'),
                            // Add additional styling if needed
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your Score: $score/${questions.length}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

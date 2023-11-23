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

class _QuizeAppState extends State<QuizeApp> with SingleTickerProviderStateMixin {
  late AnimationController _questionTextController;
  late Animation<double> _questionTextAnimation;

  int currentQuestionIndex = 0;
  bool isCorrectAnswerSelected = false;
  bool isIncorrectAnswerSelected = false;
  final List<String> selectedAnswers = [];
  bool quizFinished = false;

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
  }

  void answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        isCorrectAnswerSelected = true;
        isIncorrectAnswerSelected = false;
      } else {
        isCorrectAnswerSelected = false;
        isIncorrectAnswerSelected = true;
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
          _animateQuestionText();
        } else {
          quizFinished = true;
        }

        isCorrectAnswerSelected = false;
        isIncorrectAnswerSelected = false;
      });

      if (quizFinished) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ResultScreen(selectedAnswers: selectedAnswers);
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _questionTextController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _questionTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _questionTextController,
        curve: Curves.easeInOut,
      ),
    );

    _questionTextController.forward();
  }

  void _animateQuestionText() {
    _questionTextController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz"), backgroundColor: Color(0xFF121212)),
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
              FadeTransition(
                opacity: _questionTextAnimation,
                child: Container(
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
                    bool isCorrect = currentQuestion.isCorrectAnswer(ans);
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
                    style: GoogleFonts.agdasima(
                      textStyle: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (isIncorrectAnswerSelected)
                AnimatedOpacity(
                  opacity: isIncorrectAnswerSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Oops you are wrong...',
                    style: GoogleFonts.agdasima(
                      textStyle: TextStyle(color: Color(0xFF810505), fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
    int score = selectedAnswers.where((answer) {
      int questionIndex = selectedAnswers.indexOf(answer);
      return questions[questionIndex].isCorrectAnswer(answer);
    }).length;

    return Scaffold(
      appBar: AppBar(title: Text("Quiz Results"), backgroundColor: Color(0xFF121212)),
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
              color: Color(0xFFf2f2f2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedAnswers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Question ${index + 1}: ${selectedAnswers[index]}'),
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

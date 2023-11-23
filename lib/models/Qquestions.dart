class Qquestions{
  const Qquestions(this.text,this.answers);
  final String text;

  final List<String> answers;
  bool isCorrectAnswer(String selectedAnswer) {
    // Assuming the correct answer is always the first option
    return answers.first == selectedAnswer;
  }
  List<String>getShuffledAnswers(){
    final shuffledList=List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}


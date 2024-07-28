import 'dart:async';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> questions;
  final Function(String) onAnswerSelected;

  QuizPage({
    required this.category,
    required this.questions,
    required this.onAnswerSelected,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  int correctAnswers = 0;
  int solvedQuestions = 0;
  int timeRemaining = 180; // Total time for the quiz in seconds
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeRemaining < 1) {
          // Auto select an answer when time runs out
          if (selectedAnswer == null) {
            selectedAnswer =
                widget.questions[currentQuestionIndex]['options'][0];
          }
          nextQuestion();
        } else {
          timeRemaining--;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void nextQuestion() {
    setState(() {
      // Check if the selected answer is correct
      if (selectedAnswer == widget.questions[currentQuestionIndex]['answer']) {
        correctAnswers++;
      }
      solvedQuestions++;
      selectedAnswer = null;

      // Move to the next question
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Navigate to the result page when all questions are answered
        showResults();
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  void showResults() {
    // Navigate to ResultPage and pass quiz results
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          totalQuestions: widget.questions.length,
          correctAnswers: correctAnswers,
          onRestartQuiz: () {
            setState(() {
              currentQuestionIndex = 0;
              correctAnswers = 0;
              solvedQuestions = 0;
              timeRemaining = 180;
              selectedAnswer = null;
              startTimer();
            });
          },
        ),
      ),
    );
  }

  Color getTimerColor() {
    if (timeRemaining <= 5) {
      return Colors.red; // Color when time is running low
    }
    return Colors.green; // Normal color
  }

  String formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Questions: ${currentQuestionIndex + 1}/${widget.questions.length}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Time Left: ${formatTime(timeRemaining)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: getTimerColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Question ${currentQuestionIndex + 1}: ${widget.questions[currentQuestionIndex]['question']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Column(
              children: List.generate(
                widget.questions[currentQuestionIndex]['options'].length,
                (index) => RadioListTile(
                  title: Text(
                      widget.questions[currentQuestionIndex]['options'][index]),
                  value: widget.questions[currentQuestionIndex]['options']
                      [index],
                  groupValue: selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswer = value.toString();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: previousQuestion,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0), // Space between buttons
                ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Blue color for the button
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text('Next',
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final Function onRestartQuiz;

  ResultPage({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $correctAnswers / $totalQuestions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onRestartQuiz();
                Navigator.pop(context); // Return to quiz page
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mkcl_quiz/pages/result_page.dart';

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
          selectedAnswers: [],
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

  Color _getAppBarTextColor() {
    // Define colors for different categories
    switch (widget.category) {
      case 'General Knowledge':
        return Colors.red;
      case 'Science':
        return Colors.green;
      case 'Mathematics':
        return Colors.blue;
      case 'History':
        return Colors.orange;
      case 'Geography':
        return Colors.purple;
      case 'Technology':
        return Colors.teal;
      default:
        return Colors.black; // Default color if category is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            color: _getAppBarTextColor(),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
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

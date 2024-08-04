import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mkcl_quiz/theme_provider.dart';

class ResultPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final Function onRestartQuiz;

  ResultPage({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.onRestartQuiz,
    required List selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final double percentageScore = correctAnswers / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        centerTitle: true,
        title: Text(
          'Quiz Results',
          style: TextStyle(
            color: isDarkMode ? Colors.blue : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 13.0,
                animation: true,
                percent: percentageScore,
                center: Text(
                  '${(percentageScore * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                footer: Text(
                  "Score",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: isDarkMode ? Colors.blue : Colors.blue,
                backgroundColor: isDarkMode ? Colors.red : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'You answered $correctAnswers out of $totalQuestions questions correctly.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: isDarkMode ? Colors.white : Colors.black,
                backgroundColor: isDarkMode
                    ? Theme.of(context).primaryColor
                    : Color.fromARGB(
                        255, 234, 206, 164), // Adjust text color based on theme
              ),
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

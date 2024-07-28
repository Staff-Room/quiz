import 'package:flutter/material.dart';
import 'package:mkcl_quiz/pages/home_page.dart';
import 'package:mkcl_quiz/pages/profile_page.dart';
import 'package:mkcl_quiz/pages/quiz_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(), // Set HomePage as the starting page
      routes: {
        '/profile': (context) => ProfilePage(),
        '/quiz': (context) => QuizPage(
              category: '',
              questions: [],
              onAnswerSelected: (String) {},
            ),
      },
    );
  }
}

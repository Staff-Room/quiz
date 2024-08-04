import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkcl_quiz/pages/home_page.dart';
import 'package:mkcl_quiz/pages/profile_page.dart';
import 'package:mkcl_quiz/pages/quiz_page.dart';
import 'theme_provider.dart'; // Import the ThemeProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Quiz App',
          theme: themeProvider.currentTheme,
          home: HomePage(),
          routes: {
            '/profile': (context) => ProfilePage(),
            '/quiz': (context) => QuizPage(
                  category: '',
                  questions: [],
                  onAnswerSelected: (String) {},
                ),
          },
        );
      },
    );
  }
}

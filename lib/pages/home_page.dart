import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkcl_quiz/pages/quiz_page.dart'; // Import your QuizPage implementation
import 'package:mkcl_quiz/pages/profile_page.dart'; // Import your ProfilePage implementation
import 'package:mkcl_quiz/theme_provider.dart'; // Ensure the correct import

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "General Knowledge", "icon": Icons.public, "color": Colors.red},
    {"name": "Science", "icon": Icons.science, "color": Colors.green},
    {"name": "Mathematics", "icon": Icons.calculate, "color": Colors.blue},
    {"name": "History", "icon": Icons.book, "color": Colors.orange},
    {"name": "Geography", "icon": Icons.map, "color": Colors.purple},
    {"name": "Technology", "icon": Icons.computer, "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'MKCL QUIZ',
              style: TextStyle(
                color: isDarkMode ? Colors.blue : Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Enrich your knowledge',
              style: TextStyle(
                color: isDarkMode ? Colors.grey[300] : Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,
                color: isDarkMode ? Colors.white : Colors.blue),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: isDarkMode ? Colors.black : Colors.blue),
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    'U',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications,
                  color: isDarkMode ? Colors.white : null),
              title: Text('Notifications',
                  style: TextStyle(color: isDarkMode ? Colors.white : null)),
              onTap: () {
                Navigator.pushNamed(context, '/notifications');
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.star, color: isDarkMode ? Colors.white : null),
              title: Text('Rate Us',
                  style: TextStyle(color: isDarkMode ? Colors.white : null)),
              onTap: () {
                // Navigate to rate us page
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.feedback, color: isDarkMode ? Colors.white : null),
              title: Text('Feedback',
                  style: TextStyle(color: isDarkMode ? Colors.white : null)),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.share, color: isDarkMode ? Colors.white : null),
              title: Text('Share App',
                  style: TextStyle(color: isDarkMode ? Colors.white : null)),
              onTap: () {
                // Implement share app functionality
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_6,
                  color: isDarkMode ? Colors.white : null),
              title: Text('Switch Theme',
                  style: TextStyle(color: isDarkMode ? Colors.white : null)),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
            ListTile(
              leading:
                  Icon(Icons.logout, color: isDarkMode ? Colors.white : null),
              title: Text('Log Out',
                  style: TextStyle(color: isDarkMode ? Colors.white : null)),
              onTap: () {
                // Add your logout functionality here
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            category: categories[index]["name"],
                            onAnswerSelected: (String) {},
                            questions: _getQuestionsForCategory(
                                categories[index]["name"]),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              categories[index]["icon"],
                              color: categories[index]["color"],
                              size: 30,
                            ),
                            SizedBox(height: 8),
                            Text(
                              categories[index]["name"],
                              style: TextStyle(
                                color: categories[index]["color"],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Navigate to the test page or functionality
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: 140,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: Color.fromARGB(255, 106, 221, 89),
                  child: Center(
                    child: Text(
                      'Test',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
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

  // Hardcoded questions for demonstration
  List<Map<String, dynamic>> _getQuestionsForCategory(String category) {
    switch (category) {
      case 'General Knowledge':
        return [
          {
            'question': 'What is the capital of France?',
            'options': ['Berlin', 'Madrid', 'Paris', 'Lisbon'],
            'answer': 'Paris'
          },
          {
            'question': 'Who wrote "Hamlet"?',
            'options': [
              'Charles Dickens',
              'William Shakespeare',
              'Mark Twain',
              'Ernest Hemingway'
            ],
            'answer': 'William Shakespeare'
          },
          {
            'question': 'What is the smallest planet in our solar system?',
            'options': ['Venus', 'Mars', 'Mercury', 'Pluto'],
            'answer': 'Mercury'
          },
        ];
      case 'Science':
        return [
          {
            'question': 'What is the chemical symbol for water?',
            'options': ['H2O', 'CO2', 'O2', 'NaCl'],
            'answer': 'H2O'
          },
          {
            'question': 'What planet is known as the Red Planet?',
            'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
            'answer': 'Mars'
          },
        ];
      case 'Mathematics':
        return [
          {
            'question': 'What is the value of Pi to two decimal places?',
            'options': ['3.14', '2.71', '1.61', '1.41'],
            'answer': '3.14'
          },
          {
            'question': 'What is 7 times 8?',
            'options': ['54', '56', '58', '60'],
            'answer': '56'
          },
        ];
      case 'History':
        return [
          {
            'question': 'Who was the first President of the United States?',
            'options': [
              'George Washington',
              'Thomas Jefferson',
              'Abraham Lincoln',
              'John Adams'
            ],
            'answer': 'George Washington'
          },
          {
            'question': 'In what year did World War II end?',
            'options': ['1940', '1942', '1945', '1948'],
            'answer': '1945'
          },
        ];
      case 'Geography':
        return [
          {
            'question': 'What is the longest river in the world?',
            'options': ['Amazon', 'Nile', 'Yangtze', 'Mississippi'],
            'answer': 'Nile'
          },
          {
            'question': 'What country has the most natural lakes?',
            'options': ['Canada', 'USA', 'Brazil', 'Russia'],
            'answer': 'Canada'
          },
        ];
      case 'Technology':
        return [
          {
            'question': 'Who is the founder of Microsoft?',
            'options': [
              'Steve Jobs',
              'Bill Gates',
              'Mark Zuckerberg',
              'Elon Musk'
            ],
            'answer': 'Bill Gates'
          },
          {
            'question': 'What does CPU stand for?',
            'options': [
              'Central Processing Unit',
              'Central Process Unit',
              'Computer Personal Unit',
              'Central Processor Unit'
            ],
            'answer': 'Central Processing Unit'
          },
        ];
      default:
        return [];
    }
  }
}

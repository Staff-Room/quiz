import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mkcl_quiz/theme_provider.dart'; // Ensure the correct import

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock user data
  String _username = 'John Doe';
  String _email = 'john.doe@example.com';
  String _profilePhotoUrl = ''; // URL or empty if no photo
  String _selectedGender = ''; // Track selected gender

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: _selectProfilePhoto,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePhotoUrl.isNotEmpty
                      ? NetworkImage(_profilePhotoUrl)
                      : AssetImage('assets/default_profile.png')
                          as ImageProvider,
                  child: _profilePhotoUrl.isEmpty
                      ? Icon(Icons.add_a_photo,
                          size: 50,
                          color: isDarkMode ? Colors.white : Colors.black)
                      : null,
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildProfileItem(
              icon: Icons.person,
              title: 'Username',
              subtitle: _username,
              onTap: () {
                _editUsername(context);
              },
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16),
            _buildProfileItem(
              icon: Icons.email,
              title: 'Email',
              subtitle: _email,
              onTap: () {
                _editEmail(context);
              },
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16),
            _buildProfileItem(
              icon: Icons.cake,
              title: 'Date of Birth',
              subtitle: 'DD/MM/YYYY',
              onTap: () {
                _selectDate(context);
              },
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16),
            _buildProfileItem(
              icon: Icons.transgender,
              title: 'Gender',
              subtitle: _selectedGender.isNotEmpty
                  ? _selectedGender
                  : 'Select Gender',
              onTap: () {
                _selectGender(context);
              },
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 16),
            _buildProfileItem(
              icon: Icons.location_on,
              title: 'Location Access',
              trailing: Switch(
                value: false, // Replace with your logic for location access
                onChanged: (bool value) {
                  // Update location access logic
                },
              ),
              subtitle: '',
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.grey[800]
            : Colors.grey[200], // Background color of the container
        border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDarkMode ? Colors.grey[300] : Colors.black54,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _editUsername(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newUsername = _username;
        return AlertDialog(
          title: Text('Change Username'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Enter new username'),
            onChanged: (value) {
              newUsername = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _username = newUsername;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editEmail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEmail = _email;
        return AlertDialog(
          title: Text('Change Email'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Enter new email'),
            onChanged: (value) {
              newEmail = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _email = newEmail;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // Handle selected date
    }
  }

  void _selectGender(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Male'),
                onTap: () {
                  _updateSelectedGender('Male');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Female'),
                onTap: () {
                  _updateSelectedGender('Female');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Other'),
                onTap: () {
                  _updateSelectedGender('Other');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectedGender(String gender) {
    setState(() {
      _selectedGender = gender; // Update selected gender
    });
    // Perform any additional logic
  }

  void _selectProfilePhoto() {
    // Select profile photo logic
  }
}

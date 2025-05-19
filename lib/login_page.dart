import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'student_page.dart';
import 'teacher_page.dart';
// Import these if pages exist
// import 'parent_page.dart';
// import 'hod_page.dart';
// import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both email and password.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://your-server-address/login.php'), // Replace with your actual PHP path
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', data['role']);
        await prefs.setString('user_id', data['user_id'].toString());
        await prefs.setString('name', data['name']);

        // Navigate to respective dashboard based on role
        switch (data['role']) {
          case 'Student':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const StudentPage()),
            );
            break;
          case 'Teacher':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TeacherPage()),
            );
            break;
          // case 'Parent':
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (_) => const ParentPage()),
          //   );
          //   break;
          // case 'HOD':
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (_) => const HODPage()),
          //   );
          //   break;
          // case 'Admin':
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (_) => const AdminPage()),
          //   );
          //   break;
          default:
            _showErrorDialog('Unknown role: ${data['role']}');
        }
      } else {
        _showErrorDialog(data['message'] ?? 'Login failed.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}

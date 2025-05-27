import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Import your dashboards here
import 'student_page.dart';
import 'teacher_page.dart';
import 'staff_page.dart';
import 'parent_page.dart';
import 'hod_principal_page.dart';
import 'management_page.dart';
import 'admin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> roles = [
    'Student',
    'Teacher',
    'Staff',
    'Parent',
    'HOD',
    'Principal',
    'Management',
    'Admin',
  ];

  String? _selectedRole;
  bool _isLoading = false;

  Future<void> _login() async {
    final String fullName = _fullNameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String? role = _selectedRole;

    if (fullName.isEmpty || email.isEmpty || password.isEmpty || role == null) {
      _showDialog('Please fill in all fields and select a role');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost/school_app_prj/api/auth/login.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', data['user_id'].toString());
        await prefs.setString('name', data['name']);
        await prefs.setString('role', data['role']);

        String roleFromServer = data['role'];

        switch (roleFromServer) {
          case 'Student':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StudentPage()));
            break;
          case 'Teacher':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TeacherPage()));
            break;
          case 'Staff':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StaffPage()));
            break;
          case 'Parent':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ParentPage()));
            break;
          case 'HOD':
          case 'Principal':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HodPrincipalPage()));
            break;
          case 'Management':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ManagementPage()));
            break;
          case 'Admin':
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminPage()));
            break;
          default:
            _showDialog('Unknown role: $roleFromServer');
        }
      } else {
        _showDialog(data['message'] ?? 'Login failed');
      }
    } catch (e) {
      _showDialog('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 32),

              // Full Name
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),

              // Role Dropdown
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Select Role',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRole,
                    isExpanded: true,
                    hint: const Text('Choose your role'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    },
                    items: roles
                        .map((role) => DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Login button or loading indicator
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, 
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

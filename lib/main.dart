
import 'package:flutter/material.dart';
import 'student_page.dart';
import 'teacher_page.dart';
import 'staff_page.dart';
import 'hod_principal_page.dart';
import 'login_page.dart';
import 'management_page.dart';
import 'parent_page.dart';
import 'admin.dart'; // ✅ Keep this import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice School App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(), // 👈 Start from Login Page
      debugShowCheckedModeBanner: false,
    );
  }
}

// Optional Role Selector Screen (if you want to let user choose dashboards manually)
class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  Widget customButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 26),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo,
          minimumSize: const Size(260, 60),
          elevation: 6,
          shadowColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.indigo, width: 1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      'Select Your Role',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  customButton(
                    icon: Icons.school,
                    label: "Student Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StudentPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.person,
                    label: "Teacher Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TeacherPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.badge,
                    label: "Staff Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StaffPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.account_balance,
                    label: "HOD/Principal Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HodPrincipalPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.admin_panel_settings,
                    label: "Management Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ManagementPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.family_restroom,
                    label: "Parent Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ParentPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.admin_panel_settings_outlined,
                    label: "Admin Dashboard",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AdminPage()),
                      );
                    },
                  ),
                  customButton(
                    icon: Icons.login,
                    label: "Login",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

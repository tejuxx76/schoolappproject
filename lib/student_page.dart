import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/attendance_screen.dart';
import 'screens/marks_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/fees_screen.dart';
import 'screens/result_screen.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  final String baseUrl = 'http://localhost/school_app/api/student';
  final int studentId = 101; // Used consistently

  Future<void> fetchAndShowData(BuildContext context, String apiEndpoint, String title) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$apiEndpoint'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(const JsonEncoder.withIndent('  ').convert(data)),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ],
          ),
        );
      } else {
        throw Exception('Failed to load $title');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ],
        ),
      );
    }
  }

  Widget buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? gradientStart,
    Color? gradientEnd,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart ?? Colors.blue.shade200, gradientEnd ?? Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: iconColor ?? Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildCard(
              context: context,
              icon: Icons.assignment,
              title: 'View Attendance',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceScreen(studentId: studentId)));
              },
              gradientStart: Colors.teal.shade300,
              gradientEnd: Colors.teal.shade600,
            ),
            buildCard(
              context: context,
              icon: Icons.grade,
              title: 'View Marks',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MarksScreen(studentId: studentId)));
              },
              gradientStart: Colors.orange.shade300,
              gradientEnd: Colors.orange.shade600,
            ),
            buildCard(
              context: context,
              icon: Icons.schedule,
              title: 'View Timetable',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TimetableScreen(studentId: studentId)));
              },
              gradientStart: Colors.purple.shade300,
              gradientEnd: Colors.purple.shade600,
            ),
            buildCard(
              context: context,
              icon: Icons.attach_money,
              title: 'Fee Details',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => FeesScreen(studentId: studentId)));
              },
              gradientStart: Colors.green.shade300,
              gradientEnd: Colors.green.shade600,
            ),
            buildCard(
              context: context,
              icon: Icons.chat,
              title: 'Chat with Teachers',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Coming Soon'),
                    content: const Text('Chat feature is under development.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                    ],
                  ),
                );
              },
              gradientStart: Colors.blueGrey.shade300,
              gradientEnd: Colors.blueGrey.shade600,
            ),
            buildCard(
              context: context,
              icon: Icons.school,
              title: 'View Results',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsScreen(studentId: studentId)));
              },
              gradientStart: Colors.pink.shade300,
              gradientEnd: Colors.pink.shade600,
            ),
          ],
        ),
      ),
    );
  }
}

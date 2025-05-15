import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/attendance_screen.dart';  // Adjust the path as per your folder structure
import 'screens/marks_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/fees_screen.dart';
import 'screens/result_screen.dart';




class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  final String baseUrl = 'http://localhost/school_app/api/student'; 
  // Replace 'localhost' with your PC IP if testing on real device

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
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
  leading: const Icon(Icons.assignment),
  title: const Text('View Attendance'),
  onTap: () {
    // Navigate to AttendanceScreen instead of showing JSON dialog
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AttendanceScreen(studentId: 1)),  
    );
  },
),

          ListTile(
  leading: const Icon(Icons.grade),
  title: const Text('View Marks'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MarksScreen(studentId: 101), // use real student ID dynamically
      ),
    );
  },
),

          ListTile(
  leading: const Icon(Icons.schedule),
  title: const Text('View Timetable'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TimetableScreen(studentId: 101), // use actual student ID
      ),
    );
  },
),

          ListTile(
  leading: const Icon(Icons.attach_money),
  title: const Text('Fee Details'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeesScreen(studentId: 101), // Replace with real student ID
      ),
    );
  },
),

          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat with Teachers'),
            onTap: () {
              // This can open a chat screen or show a message for now
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Chat Feature'),
                  content: const Text('Chat feature coming soon!'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                  ],
                ),
              );
            },
          ),
          ListTile(
  leading: const Icon(Icons.school),
  title: const Text('Results'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultsScreen(studentId: 101), // Replace with actual ID
      ),
    );
  },
),

        ],
      ),
    );
  }
}

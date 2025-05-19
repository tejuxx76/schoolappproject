import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/attendance_screen.dart';  // Adjust path as needed
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
          title: const Text('Error'),
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
    // A helper function to build cards to reduce repetition
    Widget buildCard({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: Colors.blue.withAlpha(30),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: color ?? Theme.of(context).primaryColor),
                const SizedBox(height: 15),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildCard(
              icon: Icons.assignment,
              title: 'View Attendance',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceScreen(studentId: 1)),
                );
              },
            ),
            buildCard(
              icon: Icons.grade,
              title: 'View Marks',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MarksScreen(studentId: 101)),
                );
              },
            ),
            buildCard(
              icon: Icons.schedule,
              title: 'View Timetable',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TimetableScreen(studentId: 101)),
                );
              },
            ),
            buildCard(
              icon: Icons.attach_money,
              title: 'Fee Details',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FeesScreen(studentId: 101)),
                );
              },
            ),
            buildCard(
              icon: Icons.chat,
              title: 'Chat with Teachers',
              onTap: () {
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
            buildCard(
              icon: Icons.school,
              title: 'Results',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ResultsScreen(studentId: 101)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

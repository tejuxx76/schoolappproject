import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  final String baseUrl = 'http://localhost/school_app/api/teacher';
  // Use IP instead of localhost if testing on real device

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
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.green[700]),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            buildCard(
              icon: Icons.check_box,
              title: 'Take Attendance',
              onTap: () => fetchAndShowData(context, 'attendance/read.php', 'Attendance Records'),
            ),
            buildCard(
              icon: Icons.note,
              title: 'Upload Notes/Lectures',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Upload Notes'),
                    content: const Text('Upload feature coming soon!'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                    ],
                  ),
                );
              },
            ),
            buildCard(
              icon: Icons.chat,
              title: 'Chat with Students/Parents',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Chat Feature'),
                    content: const Text('Chat feature coming soon!'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                    ],
                  ),
                );
              },
            ),
            buildCard(
              icon: Icons.schedule,
              title: 'View Timetable',
              onTap: () => fetchAndShowData(context, 'timetable/read.php', 'Class Timetable'),
            ),
          ],
        ),
      ),
    );
  }
}

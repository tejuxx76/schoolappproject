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
        title: const Text('Teacher Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('Take Attendance'),
            onTap: () => fetchAndShowData(context, 'attendance/read.php', 'Attendance Records'),
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('Upload Notes/Lectures'),
            onTap: () {
              // Placeholder for upload UI
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
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat with Students/Parents'),
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
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('View Timetable'),
            onTap: () => fetchAndShowData(context, 'timetable/read.php', 'Class Timetable'),
          ),
        ],
      ),
    );
  }
}

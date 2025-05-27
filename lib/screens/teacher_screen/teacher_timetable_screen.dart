import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherTimetableScreen extends StatefulWidget {
  const TeacherTimetableScreen({super.key});

  @override
  State<TeacherTimetableScreen> createState() => _TeacherTimetableScreenState();
}

class _TeacherTimetableScreenState extends State<TeacherTimetableScreen> {
  List<dynamic> timetable = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    final url = Uri.parse('http://localhost/school_app/api/teacher/timetable/read.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          timetable = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load timetable');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Timetable')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: timetable.length,
                  itemBuilder: (context, index) {
                    final item = timetable[index];
                    return ListTile(
                      leading: const Icon(Icons.schedule),
                      title: Text('${item['subject'] ?? 'Subject'} (${item['day'] ?? '-'})'),
                      subtitle: Text(
                          'Time: ${item['start_time']} - ${item['end_time']}\nClass: ${item['class_name'] ?? '-'}'),
                    );
                  },
                ),
    );
  }
}

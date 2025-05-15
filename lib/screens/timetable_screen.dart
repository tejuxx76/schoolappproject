import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TimetableScreen extends StatefulWidget {
  final int studentId;

  const TimetableScreen({super.key, required this.studentId});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  List<dynamic> timetableList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    final url = Uri.parse(
        'http://localhost/school_app/api/student/timetable/read.php?student_id=${widget.studentId}');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        setState(() {
          timetableList = jsonData['timetable'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load timetable");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching timetable: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timetable')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : timetableList.isEmpty
              ? const Center(child: Text("No timetable available"))
              : ListView.builder(
                  itemCount: timetableList.length,
                  itemBuilder: (context, index) {
                    final item = timetableList[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(item['subject'] ?? ''),
                        subtitle: Text("${item['day']} • ${item['start_time']} - ${item['end_time']}"),
                        trailing: Text(item['teacher'] ?? ''),
                      ),
                    );
                  },
                ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  List<dynamic> attendance = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    final url = Uri.parse('http://localhost/school_app/api/teacher/attendance/read.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          attendance = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load attendance');
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
      appBar: AppBar(title: const Text('Teacher Attendance')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (context, index) {
                    final item = attendance[index];
                    return ListTile(
                      leading: const Icon(Icons.check),
                      title: Text(item['student_name'] ?? 'Unknown'),
                      subtitle: Text('Date: ${item['date'] ?? '-'}\nStatus: ${item['status'] ?? '-'}'),
                    );
                  },
                ),
    );
  }
}


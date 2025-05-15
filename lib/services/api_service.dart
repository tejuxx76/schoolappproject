import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attendance.dart';

class ApiService {
  final String baseUrl = 'http://localhost/school_app/api';  // Change as per your setup

  Future<List<Attendance>> getAttendance(int studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/student/attendance/read.php?student_id=$studentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List attendanceList = data['attendance'];

      return attendanceList.map((json) => Attendance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attendance');
    }
  }
}

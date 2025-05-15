import 'package:flutter/material.dart';
import '../models/attendance.dart';
import '../services/api_service.dart';

class AttendanceScreen extends StatefulWidget {
  final int studentId;

  const AttendanceScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late Future<List<Attendance>> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    _attendanceFuture = ApiService().getAttendance(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: FutureBuilder<List<Attendance>>(
        future: _attendanceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading attendance'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No attendance records found'));
          }

          final attendanceList = snapshot.data!;

          return ListView.builder(
            itemCount: attendanceList.length,
            itemBuilder: (context, index) {
              final attendance = attendanceList[index];
              return ListTile(
                title: Text('${attendance.subject} (Period ${attendance.period})'),
                subtitle: Text('Date: ${attendance.date}'),
                trailing: Text(attendance.status, style: TextStyle(
                  color: attendance.status == 'Present' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                )),
              );
            },
          );
        },
      ),
    );
  }
}

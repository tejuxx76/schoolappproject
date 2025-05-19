import 'package:flutter/material.dart';

class ParentAttendanceScreen extends StatelessWidget {
  const ParentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Details")),
      body: const Center(child: Text("View student attendance here")),
    );
  }
}

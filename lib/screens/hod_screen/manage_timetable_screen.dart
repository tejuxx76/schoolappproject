import 'package:flutter/material.dart';

class ManageTimetableScreen extends StatelessWidget {
  const ManageTimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Timetable")),
      body: const Center(child: Text("Timetable management goes here")),
    );
  }
}

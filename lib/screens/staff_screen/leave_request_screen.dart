import 'package:flutter/material.dart';

class LeaveRequestScreen extends StatelessWidget {
  const LeaveRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Requests")),
      body: const Center(
        child: Text("This is the Leave Request screen."),
      ),
    );
  }
}

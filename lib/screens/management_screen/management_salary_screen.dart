import 'package:flutter/material.dart';

class ManagementSalaryScreen extends StatelessWidget {
  const ManagementSalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Salaries")),
      body: const Center(child: Text("Salary calculation and display goes here")),
    );
  }
}

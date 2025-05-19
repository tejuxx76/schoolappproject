import 'package:flutter/material.dart';

class SalaryDetailsScreen extends StatelessWidget {
  const SalaryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Salary Details")),
      body: const Center(
        child: Text("This is the Salary Details screen."),
      ),
    );
  }
}

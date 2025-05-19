import 'package:flutter/material.dart';

class SalaryOverviewScreen extends StatelessWidget {
  const SalaryOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Salary Overview")),
      body: const Center(child: Text("Salary details overview here")),
    );
  }
}

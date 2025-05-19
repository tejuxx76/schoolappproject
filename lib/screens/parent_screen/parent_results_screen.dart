import 'package:flutter/material.dart';

class ParentResultsScreen extends StatelessWidget {
  const ParentResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Results")),
      body: const Center(child: Text("Student's academic results go here")),
    );
  }
}

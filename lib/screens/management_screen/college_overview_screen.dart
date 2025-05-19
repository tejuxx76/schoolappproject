import 'package:flutter/material.dart';

class CollegeOverviewScreen extends StatelessWidget {
  const CollegeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("College Overview")),
      body: const Center(child: Text("Overall college data, features, and stats")),
    );
  }
}

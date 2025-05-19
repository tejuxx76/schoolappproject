import 'package:flutter/material.dart';

class ApproveLeavesScreen extends StatelessWidget {
  const ApproveLeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Approve Leaves")),
      body: const Center(child: Text("Leave approval functionality goes here")),
    );
  }
}

import 'package:flutter/material.dart';

class ManagementFeeScreen extends StatelessWidget {
  const ManagementFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Fees")),
      body: const Center(child: Text("Fee management functionality goes here")),
    );
  }
}

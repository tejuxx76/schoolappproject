import 'package:flutter/material.dart';

class FeesOverviewScreen extends StatelessWidget {
  const FeesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fees Overview')),
      body: const Center(child: Text('Fee data and calculations go here.')),
    );
  }
}

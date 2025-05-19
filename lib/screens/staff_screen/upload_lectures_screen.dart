import 'package:flutter/material.dart';

class UploadLecturesScreen extends StatelessWidget {
  const UploadLecturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Lectures")),
      body: const Center(
        child: Text("This is the Upload Lectures screen."),
      ),
    );
  }
}

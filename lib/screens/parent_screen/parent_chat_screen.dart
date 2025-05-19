import 'package:flutter/material.dart';

class ParentChatScreen extends StatelessWidget {
  const ParentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Staff/HOD")),
      body: const Center(child: Text("Chat functionality goes here")),
    );
  }
}

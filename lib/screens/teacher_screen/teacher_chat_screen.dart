import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherChatScreen extends StatefulWidget {
  const TeacherChatScreen({super.key});

  @override
  State<TeacherChatScreen> createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  List<dynamic> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    
    final response = await http.get(
      Uri.parse('http://localhost/school_app/api/teacher/chat/read.php'),
    );
    if (response.statusCode == 200) {
      setState(() {
        messages = jsonDecode(response.body);
        isLoading = false;
      });
    }
  }

  Future<void> sendMessage() async {
    final msg = _controller.text.trim();
    if (msg.isEmpty) return;

    await http.post(
      Uri.parse('http://localhost/school_app/api/teacher/chat/send.php'),
      body: {'message': msg, 'sender': 'teacher'}, // customize as needed
    );

    _controller.clear();
    fetchMessages(); // refresh after sending
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final item = messages[index];
                      return ListTile(
                        title: Text(item['message']),
                        subtitle: Text('By: ${item['sender']} on ${item['timestamp']}'),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller)),
                IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
